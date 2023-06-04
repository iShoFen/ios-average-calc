//
//  CourseVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public class CourseVM: BaseVM, Equatable {
    public static func == (lhs: CourseVM, rhs: CourseVM) -> Bool {
        lhs.id == rhs.id
    }

    @Published
    public var isEditing: Bool = false

    @Published
    public var copy: CourseVM? = nil

    @Published
    var model: Course  {
        didSet {
            if model.name != name {
                name = model.name
            }

            if model.mark != mark {
                mark = model.mark
            }

            if model.coefficient != coefficient {
                coefficient = model.coefficient
            }

            onModelChanged()
        }
    }

    @Published
    public var name: String {
        didSet {
            if model.name != name {
                model.name = name
            }
        }
    }

    @Published
    public var mark: Double {
        didSet {
            if model.mark != mark {
                model.mark = mark
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

    public var id: UUID { model.id }

    public init(from model: Course) {
        self.model = model
        name = model.name
        mark = model.mark
        coefficient = model.coefficient
        super.init()
    }
    
    public override init() {
        let model = Course(withName: "Nouveau Cours", andMark: 0, andCoefficient: 1)
        self.model = model
        name = model.name
        mark = model.mark
        coefficient = model.coefficient
        super.init()
    }

    public func onEditing() {
        copy = CourseVM(from: model)
        isEditing = true
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
            if !onValidating(copy, &error) { return false }
            model = copy.model

            return true
        }

        return false
    }
}
