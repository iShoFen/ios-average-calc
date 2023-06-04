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

    @Published
    public var isEditing: Bool = false

    @Published
    public var copy: UEVM? = nil

    @Published
    var model: UE = UE(withName: "Nouvelle UE", andCoefficient: 1) {
        didSet {
            if model.name != name {
                name = model.name
            }

            if model.coefficient != coefficient {
                coefficient = model.coefficient
            }

            if model.courses.count != courses.count ||
                       model.courses.allSatisfy({ course in courses.contains { vm in vm.model == course } }) {
                courses = model.courses.map { CourseVM(from: $0) }
                courses.forEach { $0.addValidationFunc(course_validation) }
            }

            onModelChanged()
        }
    }

    var id: UUID { model.id }

    @Published
    public var name: String = "" {
        didSet {
            if model.name != name {
                model.name = name
            }
        }
    }

    @Published
    public var coefficient: Double = 1 {
        didSet {
            if model.coefficient != coefficient {
                model.coefficient = coefficient
            }
        }
    }

    @Published
    public var courses: [CourseVM] = [] {
        didSet {
            if model.courses.count != courses.count ||
                       model.courses.allSatisfy({ course in courses.contains { vm in vm.model == course } }) {
                _ = model.updateCourses(from: courses.map { $0.model })
            }
        }
    }

    public var average: Double { model.average }

    public init(from model: UE) {
        super.init()
        self.model = model
    }

    public func onEditing() {
        isEditing = true
        copy = UEVM(from: model)
    }

    public func onEdited(isCanceled canceled: Bool, error: inout String) -> Bool {
        if !isEditing { return false }

        if !canceled && !update(error: &error) { return false }

        copy = nil
        isEditing = false

        return true
    }

    private func update(error: inout String) -> Bool {
        if let copy = copy {

            if !onValidating(copy, &error) || !course_validation(copy: copy, error: &error) {
                return false
            }
            model = copy.model

            return true
        }

        return false
    }

    private func course_validation(copy: BaseVM, error: inout String) -> Bool {
        if let courseVM = copy as? CourseVM {
            if courses.contains(where: { $0.name == courseVM.name && $0 != courseVM}) {
                error = "Le nom de cours est déjà utilisé. Veuillez le changer afin de sauvegarder les modifications !"
                return false
            }
        }

        return true
    }
}
