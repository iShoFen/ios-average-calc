//
//  UCAVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import Foundation
import AverageCalcModel

public class UCAVM: ObservableObject {
    @Published
    public var blocks: [Block] = []

    public init(withBlock blocks: [Block]) {
        self.blocks = blocks
    }
    
    public func checkBlockNameAvailability(of data: Block.Data) -> Bool {
        var result = true
        blocks.forEach { block in
            if block.name == data.name && block.id != data.id {
                result = false
            }
        }

        return result
    }

    public func checkUENameAvailability(of data: UE.Data) -> Bool {
        let totalIndex = blocks.firstIndex(where: { $0.name == "Total" })!
        return !blocks[totalIndex].ues.contains(where: { $0.name == data.name && $0.id != data.id })
    }

    public func removeBlock(with blockVM: BlockVM) {
        if let index = blocks.firstIndex(where: { $0.id == blockVM.original.id }) {
            if blocks[index].name != "Total" {
                blocks.remove(at: index)
            }
        }
    }

    public func updateUE (with ue: UEVM) -> Bool {
        var tmpBlocks = blocks
        for i in 0..<tmpBlocks.count {
            var tmpUes = tmpBlocks[i].ues
            if let index = tmpUes.firstIndex(where: { $0.id == ue.original.id }) {
                tmpUes[index] = ue.original
            }

            if !tmpBlocks[i].updateUEs(from: tmpUes) {
                return false
            }
        }

        blocks = tmpBlocks
        return true
    }

    public func update(with block: BlockVM) -> Bool {
        if !updateOthersOthersBlocks(block.original) {
            return false
        }

        if !blocks.contains(where: { $0.id == block.original.id }) {
            blocks.append(block.original)
        }

        return true
    }

    private func updateOthersOthersBlocks(_ block: Block) -> Bool {
        var tmpBlocks = blocks
        let isBlockTotal = block.name == "Total"

        for (index, tmpBlock) in tmpBlocks.enumerated() {
            if (tmpBlock == block) {
                tmpBlocks[index] = block
                continue
            }

            var tmpUes = tmpBlock.ues
            if isBlockTotal {
                tmpUes.removeAll { ue in !block.ues.contains { $0.id == ue.id }  }
            }

            update(UEs: &tmpUes, fromBlock: tmpBlock)

            if (tmpBlock.name == "Total") {
                tmpUes.append(contentsOf: block.ues.filter({ ue in !tmpBlock.ues.contains(where: { $0.id == ue.id }) }))
            }

            if !tmpBlocks[index].updateUEs(from: tmpUes) {
                return false
            }
        }

        blocks = tmpBlocks

        return true
    }

    private func update(UEs ues: inout [UE], fromBlock block: Block) {
        for ue in block.ues {
            if let index = ues.firstIndex(where: { $0.id == ue.id }) {
                ues[index] = ue
            }
        }
    }
}
