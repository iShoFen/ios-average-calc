//
//  UCAVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import Foundation
import AverageCalcModel

public class UCAVM: ObservableObject, Identifiable, Equatable, Hashable {
    public static func == (lhs: UCAVM, rhs: UCAVM) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    var model: UCA

    public var id: UUID { model.id }

    @Published
    public var blocks: [BlockVM]
    
    @Published
    public var selectedBlock: BlockVM = BlockVM()
    
    public private(set) var totalIndex: Int = 0

    public init(from model: UCA) {
        self.model = model
        blocks = model.blocks.map { BlockVM(from: $0) }
        blocks.forEach { addCallbacks(block: $0) }
        
        totalIndex = blocks.firstIndex(where: { $0.name == "Total" })!
        selectedBlock = blocks[totalIndex]
    }

    private func addCallbacks(block: BlockVM) {
        block.subscribeUpdate(with: self, and: blockVM_changed)
        block.subscribeValidation(with: self, and: block_validation)
        block.subscribeValidation(with: selectedBlock, and: ue_validation)
    }

    public func addBlock(_ block: BlockVM, error: inout String) -> Bool {
        if !block_validation(copy: block, error: &error) {
            return false
        }

        if !ue_validation(copy: block, error: &error) {
            return false
        }
        
        blockVM_changed(baseVM: block)

        return true
    }

    public func removeBlock(_ block: BlockVM) {
        let removed = model.remove(block: block.model)
        if removed {
            if let index = blocks.firstIndex(of: block) {
                blocks.remove(at: index)
            }
        }
    }

    private func blockVM_changed(baseVM: BaseVM) {
        if let blockVM = baseVM as? BlockVM {
            if model.updateBlocks(with: blockVM.model) {
                blocks = model.blocks.map { BlockVM(from: $0) }
                blocks.forEach { addCallbacks(block: $0) }
                selectedBlock = blocks[totalIndex]
            }
        }
    }

    private func block_validation(copy: BaseVM, error: inout String) -> Bool {
        if let blockVM = copy as? BlockVM {
            if !model.checkBlockNameAvailability(of: blockVM.model) {
                error = "Le nom du bloc doit être unique. Veuillez le changer afin de sauvegarder les modifications ! "
                return false
            }
        }
        return true
    }

    private func ue_validation(copy: BaseVM, error: inout String) -> Bool {
        if let ueVM = copy as? UEVM {
            if !model.checkUENameAvailability(of: ueVM.model) {
                error = "Le nom de l'UE est utilisé dans un autre bloc. Veuillez le changer afin de sauvegarder les modifications ! "
                return false
            }
        }
        return true
    }
}
