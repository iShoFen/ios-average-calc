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
        public var courses: [Course.Data]
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
            return false
        }

        let fail = !updateCourses(from: data.courses.map { $0.toCourse() })
        if fail { return false }

        name = data.name
        coefficient = data.coefficient
        return true
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

    public func onEdited(isCancelled: Bool = false) -> Bool {
        if isCancelled {
            isEditing = false
            model = original.data
            return true
        }
        
        if original.update(from: model) {
            isEditing = false

            return true
        }

        return false
    }

    public func updateCourse(fromCourseVM courseVM: CourseVM) {
        if let index = model.courses.firstIndex(where: { $0.id == courseVM.model.id }) {
            model.courses[index] = courseVM.model
            _ = onEdited()
        }
    }
}
