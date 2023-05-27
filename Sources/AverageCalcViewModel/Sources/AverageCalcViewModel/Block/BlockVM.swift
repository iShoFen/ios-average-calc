//
//  BlockVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public extension Block {
    struct Data: Identifiable {
        public let id: UUID
        public var name: String
        public fileprivate(set) var ues: [UE.Data]
        public var average: Double

        func toBlock() -> Block {
            Block(id: id, name: name, ues: ues.map { $0.toUE() })
        }
    }

    var data: Data {
        Data(id: id,
            name: name,
            ues: ues.map { $0.data },
            average: average)
    }

    mutating func update(from data: Data) -> Bool {
        guard self.id == data.id else {
            return true
        }

        name = data.name
        return updateUEs(from: data.ues.map { $0.toUE() })
    }
}

public class BlockVM: ObservableObject {
    public var original: Block

    @Published
    public var model: Block.Data

    @Published
    public var isEditing: Bool = false

    public init(fromBlock block: Block) {
        original = block
        model = block.data
    }

    func onEditing() {
        model = original.data
        isEditing = true
    }

    func tryAddUE(ue: UE.Data) -> Bool {
        if isEditing && original.canAddUE(ue.toUE()) {
            model.ues.append(ue)
            return true
        }
        return false
    }

    func tryRemoveUE(ue: UE.Data) -> Bool {
        if isEditing && original.canRemoveUE(ue.toUE()) {
            model.ues.removeAll { $0.id == ue.id }
            return true
        }
        return false
    }

    func onEdited(isCancelled: Bool) -> Bool {
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
