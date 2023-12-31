//
//  Block.swift
//  AverageCalcModel
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import Foundation

public struct Block: Identifiable, Equatable, Codable {
    public static func == (lhs: Block, rhs: Block) -> Bool {
        lhs.id == rhs.id
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
    
    public private(set) var ues: [UE]
    
    public var average: Double {
        get {
            var average = 0.0
            var coefficient = 0.0

            for ue in ues {
                average += ue.average * ue.coefficient
                coefficient += ue.coefficient
            }
            
            return coefficient == 0 ? 0 : average / coefficient
        }
    }
    
    public init(withId id: UUID, andName name: String, andUes ues: [UE] = []) {
        self.id = id
        _name = name
        self.ues = ues
    }

    public init(withName name: String, andUes ues: [UE] = []) {
        self.init(withId: UUID(), andName: name, andUes: ues)
    }

    public mutating func addUE(_ ue: UE) -> Bool {
        guard !ues.contains(where: { $0.id == ue.id && $0.name == ue.name }) else {
            return false
        }
        ues.append(ue)
        
        return true
    }

    public mutating func removeUE(_ ue: UE) -> Bool {
        guard ues.contains(where: { $0 == ue}) else {
            return false
        }
        
        ues.remove(at: ues.firstIndex(where: { $0 == ue })!)
        
        return true
    }

    public func canUpdateUEs(from ues: [UE]) -> Bool {
        let ids = ues.map { $0.id }
        let names = ues.map { $0.name }

        guard Set(ids).count == ids.count && Set(names).count == names.count else {
            return false
        }

        return true
    }

    public mutating func updateUEs(from ues: [UE]) -> Bool {
        guard canUpdateUEs(from: ues) else {
            return false
        }

        self.ues = ues

        return true
    }

    public func canUpdateUE(from ue: UE) -> Bool {
        guard ues.contains(where: { $0 == ue }) else {
            return false
        }

        guard !ues.contains(where: { $0.name == ue.name && $0 != ue }) else {
            return false
        }

        return true
    }

    public mutating func updateUE(from ue: UE) -> Bool {
        guard canUpdateUE(from: ue) else {
            return false
        }

        ues[ues.firstIndex(where: { $0.id == ue.id })!] = ue

        return true
    }
}
