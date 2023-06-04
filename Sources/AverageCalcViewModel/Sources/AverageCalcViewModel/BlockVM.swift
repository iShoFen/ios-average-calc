//
//  BlockVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public class BlockVM: BaseVM, Equatable {
    public static func == (lhs: BlockVM, rhs: BlockVM) -> Bool {
        lhs.id == rhs.id
    }

    @Published
    public var isEditing: Bool = false

    @Published
    public var copy: BlockVM? = nil

    @Published
    var model: Block = Block(withName: "Nouveau Bloc") {
        didSet {
            if model.name != name {
                name = model.name
            }

            if model.ues.count != ues.count ||
                model.ues.allSatisfy({ ue in ues.contains { vm in vm.model == ue } }) {
                ues = model.ues.map { UEVM(from: $0) }
                ues.forEach { ue in
                    ue.addValidationFunc(ue_validation)
                    validationFuncs.forEach {
                        ue.addValidationFunc($0)
                    }
                }
            }

            onModelChanged()
        }
    }

    var id: UUID { model.id }

    var average: Double { model.average }

    @Published
    public var name: String = "" {
        didSet {
            if model.name != name {
                model.name = name
            }
        }
    }

    @Published
    public var ues: [UEVM] = [] {
        didSet {
            if model.ues.count != ues.count ||
                model.ues.allSatisfy({ ue in ues.contains { vm in vm.model == ue } }) {
                _ = model.updateUEs(from: ues.map { $0.model })
            }
        }
    }

    public init(from model: Block) {
        super.init()
        self.model = model
    }

    public func onEditing() {
        copy = BlockVM(from: model)
        isEditing = true
    }

    public func onEdited(isCanceled canceled: Bool, error: inout String) -> Bool {
        if !isEditing { return false }
        if !canceled && !update(error: &error) { return false }

        copy = nil
        isEditing = false

        return true
    }

    private func update(error: inout String) -> Bool {
        if let copy = copy {
            if !onValidating(copy, &error) || !ue_validation(copy: copy, error: &error) {
                return false
            }
            model = copy.model

            return true
        }
        return false
    }

    private func ue_validation(copy: BaseVM, error: inout String) -> Bool {
        if let ueVM = copy as? UEVM {
            if ues.contains(where: { $0.name == ueVM.name && $0 != ueVM}) {
                error = "Une UE avec le même nom existe déjà. Veuillez le changer afin de sauvegarder les modifications !"
                return false
            }
        }

        return true
    }

}
