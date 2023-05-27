//
//  CourseVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public extension Course {
    struct Data: Identifiable {
        public let id: UUID
        public var name: String
        public var mark: Double
        public var coefficient: Double

        func toCourse() -> Course {
            Course(id: id, name: name, mark: mark, coefficient: coefficient)
        }
    }

    var data: Data {
        Data(id: id, name: name, mark: mark, coefficient: coefficient)
    }

    mutating func update(from data: Data) {
        guard self.id == data.id else {return}
        name = data.name
        mark = data.mark
        coefficient = data.coefficient
    }
}

public class CourseVM: ObservableObject {
    public var original: Course

    @Published
    public var model: Course.Data

    @Published
    public var isEditing: Bool = false

    public init(fromCourse course: Course) {
        original = course
        model = course.data
    }

    public func onEditing() {
        model = original.data
        isEditing = true
    }

    public func onEdited(isCancelled: Bool = false) {
        if !isCancelled {
            original.update(from: model)
        }
        isEditing = false
    }
    
    public func toggleEditing() {
        isEditing ? onEdited() : onEditing()
    }
}
