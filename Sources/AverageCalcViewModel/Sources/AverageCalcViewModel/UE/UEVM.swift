//
//  UEVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public extension UE {
    struct Data: Identifiable {
        public let id: UUID
        public var name: String
        public var coefficient: Double
        public fileprivate(set) var courses: [Course.Data]
        public var average: Double

        func toUE() -> UE {
            UE(id: id, name: name, coefficient: coefficient, courses: courses.map { $0.toCourse() })
        }
    }

    var data: Data {
        Data(id: id,
            name: name,
            coefficient: coefficient,
            courses: courses.map { $0.data },
            average: average)
    }

    mutating func update(from data : Data) -> Bool {
        guard self.id == data.id else {
            return true
        }

        name = data.name
        coefficient = data.coefficient
        return updateCourses(from: data.courses.map { $0.toCourse() })
    }
}

public class UEVM: ObservableObject {
    public var original: UE

    @Published
    public var model: UE.Data
    @Published
    public var isEditing: Bool = false

    public init(fromUE ue: UE) {
        original = ue
        model = ue.data
    }

    public func onEditing() {
        model = original.data
        isEditing = true
    }

    public func tryAddCourse(course: Course.Data) -> Bool {
        if isEditing && original.canAddCourse(course.toCourse()) {
            model.courses.append(course)

            return true
        }

        return false
    }
    
    public func tryRemoveCourse(course: Course.Data) -> Bool {
        if isEditing && original.canRemoveCourse(course.toCourse()) {
            model.courses.removeAll(where: { $0.id == course.id })

            return true
        }

        return false
    }

    public func onEdited(isCancelled: Bool = false) -> Bool {
        var result = false
        if !isCancelled {
           result = original.update(from: model)
        }

        if result {
            isEditing = false

            return true
        }

        return false
    }
}
