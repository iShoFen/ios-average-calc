//
// Created by etudiant on 25/05/2023.
//

import Foundation

public struct Block {
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

    public private(set) var ues: [UE]

    public var average: Double {
        get {
            var average = 0.0
            var coefficient = 0.0

            for ue in ues {
                average += ue.average.value * ue.average.coefficient
                coefficient += ue.average.coefficient
            }

            return average / coefficient
        }
    }

    public init(name: String, ues: [UE]) {
        _name = name
        self.ues = ues
    }

    public mutating func addUE(_ ue: UE) -> Bool {
        guard !ues.contains(where: { $0.name == ue.name }) else {
            return false
        }

        ues.append(ue)

        return true
    }

    public mutating func removeUE(_ ue: UE) -> Bool {
        guard let index = ues.firstIndex(where: { $0.name == ue.name }) else {
            return false
        }

        ues.remove(at: index)

        return true
    }
}