//
//  File.swift
//  
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

public struct Course {
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

    public init(name: String, mark: Double, coefficient: Double) {
        _name = name
        _mark = mark
        _coefficient = coefficient
    }
}
