//
//  Course.swift
//  AverageCalcModel
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import Foundation

public struct Course: Identifiable, Hashable {
    public static func == (lhs: Course, rhs: Course) -> Bool {
        lhs.id == rhs.id
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public let id: UUID

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

    public var mark: Double {
        get { _mark }
        set {
            guard newValue >= 0 && newValue <= 20 else {
                return
            }

            _mark = newValue
        }
    }
    private var _mark: Double


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

    public init(id: UUID = UUID(), name: String, mark: Double, coefficient: Double) {
        self.id = id
        _name = name
        _mark = mark
        _coefficient = coefficient
    }
}
