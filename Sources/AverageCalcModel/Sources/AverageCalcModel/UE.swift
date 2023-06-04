//
//  UE.swift
//  AverageCalcModel
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import Foundation

public struct UE: Identifiable, Equatable {
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

            return coefficient == 0 ? 0 : average / coefficient
        }
    }

    public init(withId id: UUID, andName name: String, andCoefficient coefficient: Double, andCourses courses: [Course]) {
        self.id = id
        _name = name
        _coefficient = coefficient
        self.courses = courses
    }

    public init(withName name: String, andCoefficient coefficient: Double, andCourses courses: [Course] = []) {
        self.init(withId: UUID(), andName: name, andCoefficient: coefficient, andCourses: courses)
    }

    public mutating func addCourse(_ course: Course) -> Bool {
        guard !courses.contains(where: { $0 == course && $0.name == course.name }) else {
            return false
        }

        courses.append(course)

        return true
    }

    public mutating func removeCourse(_ course: Course) -> Bool {
        guard courses.contains(where: { $0 == course }) else {
            return false
        }

        courses.remove(at: courses.firstIndex(where: { $0 == course })!)

        return true
    }

    public func canUpdateCourses(from courses: [Course]) -> Bool {
        let ids = courses.map { $0.id }
        let names = courses.map { $0.name }

        return Set(ids).count == ids.count && Set(names).count == names.count
    }

    public mutating func updateCourses(from courses: [Course]) -> Bool {
        guard canUpdateCourses(from: courses) else {
            return false
        }

        self.courses = courses

        return true
    }

    public func canUpdateCourse(from course: Course) -> Bool {
        guard courses.contains(where: { $0 == course }) else {
            return false
        }

        guard !courses.contains(where: { $0.name == course.name && $0 != course }) else {
            return false
        }

        return true
    }

    public mutating func updateCourse(from course: Course) -> Bool {
        guard canUpdateCourse(from: course) else {
            return false
        }

        courses[courses.firstIndex(where: { $0 == course })!] = course

        return true
    }
}
