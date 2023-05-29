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
        public var ues: [UE.Data]
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
            return false
        }
        let fail = !updateUEs(from: data.ues.map { $0.toUE() })
        if fail { return false }

        name = data.name
        return true
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
    
    public func updateUE(fromUEVM ueVM: UEVM) {
        if let index = model.ues.firstIndex(where: { $0.id == ueVM.model.id }) {
            model.ues[index] = ueVM.model
            _ = onEdited()
        }
    }
}
