//
// Created by etudiant on 25/05/2023.
//

import Foundation

public struct UE {
    public var name: String {
        get { _name }
        set {
            guard !newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                return
            }

            _name = newValue
        }
    }
    private var _name: String

    public private(set) var courses: [Course]

    public var average: (value: Double, coefficient: Double) {
        get {
            var average = 0.0
            var coefficient = 0.0

            for course in courses {
                average += course.mark * course.coefficient
                coefficient += course.coefficient
            }

            return (average / coefficient, coefficient)
        }
    }

    public init(name: String, courses: [Course]) {
        _name = name
        self.courses = courses
    }

    public mutating func addCourse(_ course: Course) -> Bool {
        guard !courses.contains(where: { $0.name == course.name }) else {
            return false
        }

        courses.append(course)

        return true
    }

    public mutating func removeCourse(_ course: Course) -> Bool {
        guard let index = courses.firstIndex(where: { $0.name == course.name }) else {
            return false
        }

        courses.remove(at: index)

        return true
    }
}