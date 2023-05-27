//
//  UE.swift
//  AverageCalcModel
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import Foundation

public struct UE: Identifiable {
    public static func == (lhs: UE, rhs: UE) -> Bool {
        lhs.id == rhs.id
    }

    public let id: UUID

    public var name: String {
        get { _name }
        set {
            let filtered = newValue.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !filtered.isEmpty else {
                return
            }

            _name = filtered
        }
    }
    private var _name: String

    public var coefficient: Double {
        get { _coefficient }
        set {
            guard newValue > 0 else {
                return
            }

            _coefficient = newValue
        }
    }
    private var _coefficient: Double

    public private(set) var courses: [Course]

    public var average: Double {
        get {
            var average = 0.0
            var coefficient = 0.0

            for course in courses {
                average += course.mark * course.coefficient
                coefficient += course.coefficient
            }

            return average / coefficient
        }
    }

    public init(id: UUID = UUID(), name: String, coefficient: Double, courses: [Course]) {
        self.id = id
        _name = name
        _coefficient = coefficient
        self.courses = courses
    }

    public func canAddCourse(_ course: Course) -> Bool {
        !courses.contains(where: { $0.name == course.name })
    }

    public mutating func addCourse(_ course: Course) -> Bool {
        guard canAddCourse(course) else {
            return false
        }

        courses.append(course)

        return true
    }

    public func canRemoveCourse(_ course: Course) -> Bool {
        courses.contains(where: { $0 == course })
    }

    public mutating func updateCourses(from courses: [Course]) -> Bool {
        let ids = courses.map { $0.id }
        let names = courses.map { $0.name }


        guard Set(ids).count == ids.count && Set(names).count == names.count else {
            return false
        }

        self.courses = courses

        return true
    }
}
