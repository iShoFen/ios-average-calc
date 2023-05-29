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

    public func checkUENameAvailability(name: String) -> Bool {
        let totalIndex = blocks.firstIndex(where: { $0.name == "Total" })
        return !blocks[totalIndex!].ues.contains(where: { $0.name == name })
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
            for j in 0..<tmpUes.count {
                if tmpUes[j].id == ue.original.id {
                    tmpUes[j] = ue.original
                }
            }
            if !tmpBlocks[i].updateUEs(from: tmpUes) {
                return false
            }
        }

        blocks = tmpBlocks
        return true
    }

    public func update(with block: BlockVM) -> Bool {
        if let index = blocks.firstIndex(where: { $0.id == block.original.id }) {
            if blocks[index].name != "Total" {
                if updateTotalIfOthers(block.original) {
                    return false
                }
                blocks[index] = block.original
            } else if updateOthersIfTotal(block.original) {
                return false
            }
        } else {
            if updateTotalIfOthers(block.original) {
                return false
            }
            blocks.append(block.original)
        }
        
        return true
    }

    private func updateTotalIfOthers(_ block: Block) -> Bool {
        let totalIndex = blocks.firstIndex(where: { $0.name == "Total" })
        var tmpTotal = blocks[totalIndex!]
        var tmpUes = tmpTotal.ues

        for i in 0..<block.ues.count {
            if !block.ues.contains(where: { $0.id == tmpUes[i].id }) {
                tmpUes.append(block.ues[i])
            } else {
                tmpUes[i] = block.ues[i]
            }
        }

        if !tmpTotal.updateUEs(from: tmpUes)  {
            return false
        }

        blocks[totalIndex!] = tmpTotal

        return true
    }
    
    private func updateOthersIfTotal(_ block: Block) -> Bool {
        var tmpBlocks = blocks
        for i in 0..<tmpBlocks.count {
            var tmpUes = blocks[i].ues
            for j in 0..<blocks[i].ues.count {
                if !block.ues.contains(where: { $0.id == blocks[i].ues[j].id }) {
                    tmpUes.remove(at: j)
                } else {
                    tmpUes[j] = block.ues[j]
                }
            }
            if !tmpBlocks[i].updateUEs(from: tmpUes) {
                return false
            }
        }

        blocks = tmpBlocks

        return true
    }
}
