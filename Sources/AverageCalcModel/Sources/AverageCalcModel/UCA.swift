//
// Created by etudiant on 04/06/2023.
//

import Foundation

public struct UCA: Identifiable, Equatable {

    public static func == (lhs: UCA, rhs: UCA) -> Bool {
        lhs.id == rhs.id
    }

    public let id: UUID

    public private(set) var blocks: [Block]

    public init(with id: UUID, andBlocks blocks: [Block]) {
        self.id = id
        self.blocks = blocks
    }

    public init(withBlocks blocks: [Block] = []) {
        self.init(with: UUID(), andBlocks: blocks)
    }

    public func checkBlockNameAvailability(of other: Block) -> Bool {
        var result = true
        blocks.forEach { block in
            if block.name == other.name && block != other {
                result = false
            }
        }

        return result
    }

    public func checkUENameAvailability(of other: UE) -> Bool {
        let totalIndex = blocks.firstIndex(where: { $0.name == "Total" })!

        return !blocks[totalIndex].ues.contains{ $0.name == other.name && $0 != other }
    }

    public mutating func remove(block: Block) -> Bool {
        if let index = blocks.firstIndex(where: { $0.id == block.id }) {
            if blocks[index].name != "Total" {
                blocks.remove(at: index)

                return true
            }
        }

        return false
    }

    public mutating func updateBlocks(with block: Block) -> Bool {
        if !updateOtherBlocks(with: block) {
            return false
        }

        if !blocks.contains(where: { $0 == block }) {
            blocks.append(block)
        }

        return true
    }

    private mutating func updateOtherBlocks(with block: Block) -> Bool {
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

            update(UEs: &tmpUes, fromBlock: block)

            if (tmpBlock.name == "Total") {
                tmpUes.append(contentsOf: block.ues.filter({ ue in !tmpBlock.ues.contains(where: { $0 == ue }) }))
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
            if let index = ues.firstIndex(where: { $0 == ue }) {
                ues[index] = ue
            }
        }
    }
}
