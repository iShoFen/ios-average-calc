//
//  BlockVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public class BlockVM: BaseVM, Equatable, Hashable {
    public static func == (lhs: BlockVM, rhs: BlockVM) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    private let ueError = "Une UE avec le même nom existe déjà. Veuillez le changer afin de sauvegarder les modifications !"

    @Published
    public var isEditing: Bool = false

    @Published
    public var copy: BlockVM? = nil

    @Published
    var model: Block {
        willSet(newValue) {
            if model.ues.count != ues.count ||
                !model.ues.allSatisfy({ ue in ues.contains { vm in vm.model == ue } }) {
                           ues.forEach { $0.unsubscribeUpdate(with: self) }
                           ues.forEach { $0.unsubscribeValidation(with: self) }
            }
        }
        didSet {
            if model.name != name {
                name = model.name
            }

            if model.ues.count != ues.count ||
                !model.ues.allSatisfy({ ue in ues.contains { vm in vm.model == ue } }) {
                ues = model.ues.map { UEVM(from: $0) }
                ues.forEach { addCallbacks(ueVM: $0) }
            }

            
            onModelChanged()
        }
    }

    public var id: UUID { model.id }

    public var average: Double { model.average }

    @Published
    public var name: String {
        didSet {
            if model.name != name {
                model.name = name
            }
        }
    }

    @Published
    public var ues: [UEVM] {
        didSet {
            if model.ues.count != ues.count ||
                !model.ues.allSatisfy({ ue in ues.contains { vm in vm.model == ue } }) {
                _ = model.updateUEs(from: ues.map { $0.model })
            }
        }
    }

    public init(from model: Block) {
        self.model = model
        name = model.name
        ues = model.ues.map { UEVM(from: $0) }
        super.init()

        ues.forEach { addCallbacks(ueVM: $0) }
    }
    
    public override init() {
        let model = Block(withName: "Nouveau Bloc")
        self.model = model
        name = model.name
        ues = []
        super.init()
    }

    private func addCallbacks(ueVM: UEVM) {
        ueVM.subscribeUpdate(with: self, and: ueVM_changed)
        ueVM.subscribeValidation(with: self, and: ue_validation)
        validationFuncs.forEach {
            ueVM.subscribeValidation(with: self, and: $0.value)
        }
    }
    
    public func onEditing() {
        copy = BlockVM(from: model)
        isEditing = true
    }

    public func onEdited(isCanceled canceled: Bool = false, error: inout String) -> Bool {
        if !isEditing { return false }
        if !canceled && !update(error: &error) { return false }

        copy = nil
        isEditing = false

        return true
    }

    private func update(error: inout String) -> Bool {
        if let copy = copy {
            if !onValidating(copy, &error) {
                return false
            }

            if !copy.model.canUpdateUEs(from: copy.ues.map { $0.model }) {
                error = ueError
                return false
            }
            name = copy.name
            _ = model.updateUEs(from: copy.ues.map { $0.model })
            ues = copy.ues.map { UEVM(from: $0.model) }
            ues.forEach { addCallbacks(ueVM: $0) }

            return true
        }
        return false
    }
    
    private func ueVM_changed(baseVM: BaseVM) {
        if let ueVM = baseVM as? UEVM {
            if model.updateUE(from: ueVM.model) {
                objectWillChange.send()
            }
        }
    }

    private func ue_validation(copy: BaseVM, error: inout String) -> Bool {
        if let ueVM = copy as? UEVM {
            if !model.canUpdateUE(from: ueVM.model) {
                error = ueError
                return false
            }
        }

        return true
    }

}
