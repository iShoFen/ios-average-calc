//
//  BlocksVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public class BlocksVM: ObservableObject {
    @Published
    public var blocks: [Block] = []

    public init(withBlock blocks: [Block]) {
        self.blocks = blocks
    }

    public func update(with block: BlockVM) {
        if let index = blocks.firstIndex(where: { $0.id == block.original.id }) {
            blocks[index] = block.original
        } else {
            blocks.append(block.original)
        }
    }
}
