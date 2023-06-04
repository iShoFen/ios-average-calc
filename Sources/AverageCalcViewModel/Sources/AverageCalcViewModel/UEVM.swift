//
//  UEVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public class UEVM: BaseVM, Equatable {
    public static func == (lhs: UEVM, rhs: UEVM) -> Bool {
        lhs.id == rhs.id
    }
    
    private let courseError = "Le nom de cours est déjà utilisé. Veuillez le changer afin de sauvegarder les modifications !"


    @Published
    public var isEditing: Bool = false

    @Published
    public var copy: UEVM? = nil

    @Published
    var model: UE {
        didSet {
            if model.name != name {
                name = model.name
            }

            if model.coefficient != coefficient {
                coefficient = model.coefficient
            }

            if model.courses.count != courses.count ||
                       !model.courses.allSatisfy({ course in courses.contains { vm in vm.model == course } }) {
                courses = model.courses.map { CourseVM(from: $0) }
                courses.forEach { addCallbacks(courseVM: $0) }
            }

            onModelChanged()
        }
    }

    public var id: UUID { model.id }

    @Published
    public var name: String {
        didSet {
            if model.name != name {
                model.name = name
            }
        }
    }

    @Published
    public var coefficient: Double {
        didSet {
            if model.coefficient != coefficient {
                model.coefficient = coefficient
            }
        }
    }

    @Published
    public var courses: [CourseVM] {
        didSet {
            if model.courses.count != courses.count ||
                       !model.courses.allSatisfy({ course in courses.contains { vm in vm.model == course } }) {
                _ = model.updateCourses(from: courses.map { $0.model })
            }
        }
    }

    public var average: Double { model.average }

    public init(from model: UE) {
        self.model = model
        name = model.name
        coefficient = model.coefficient
        courses = model.courses.map { CourseVM(from: $0) }
        super.init()

        courses.forEach { addCallbacks(courseVM: $0) }
    }
    
    public override init() {
        let model = UE(withName: "Nouvelle UE", andCoefficient: 1)
        self.model = model
        name = model.name
        coefficient = model.coefficient
        courses = []
        super.init()
    }

    public func addCallbacks(courseVM: CourseVM) {
        courseVM.addUpdatedFunc(courseVM_changed)
        courseVM.addValidationFunc(course_validation)
    }

    public func onEditing() {
        isEditing = true
        copy = UEVM(from: model)
    }

    public func onEdited(isCanceled canceled: Bool = false, error: inout String) -> Bool {
          if !isEditing { return false }

        if !canceled && !update(error: &error) { return false }

        copy = nil
        isEditing = false
        return true
    }

    private func update(error: inout String) -> Bool {
        if let copy = copy {

            if !onValidating(copy, &error) {
                return false
            }

            if !copy.model.canUpdateCourses(from: copy.courses.map { $0.model }) {
                error = courseError
                return false
            }
            model = copy.model

            courses = copy.courses.map { CourseVM(from: $0.model) }
            courses.forEach { addCallbacks(courseVM: $0) }

            return true
        }

        return false
    }

    private func courseVM_changed(_ baseVM: BaseVM) {
        if let courseVM = baseVM as? CourseVM {
            if model.updateCourse(from: courseVM.model) {
                objectWillChange.send()
            }
        }
    }

    private func course_validation(copy: BaseVM, error: inout String) -> Bool {
        if let courseVM = copy as? CourseVM {
            if !model.canUpdateCourse(from: courseVM.model) {
                error = courseError
                return false
            }
        }

        return true
    }
}
