//
// Created by etudiant on 04/06/2023.
//

import Foundation

public class BaseVM: ObservableObject, Identifiable {
    var updatedFuncs: [(BaseVM) -> ()] = []

    var validationFuncs: [(BaseVM, inout String) -> Bool] = []

    func addUpdatedFunc(_ funcToAdd: @escaping (BaseVM) -> ()) {
        updatedFuncs.append(funcToAdd)
    }

    func addValidationFunc(_ funcToAdd: @escaping (BaseVM, inout String) -> Bool) {
        validationFuncs.append(funcToAdd)
    }

    func onModelChanged() {
        for funcToCall in updatedFuncs {
            funcToCall(self)
        }
    }

    func onValidating(_ copy: BaseVM, _ message: inout String) -> Bool {
        for funcToCall in validationFuncs {
            if !funcToCall(copy, &message) {
                return false
            }
        }
        return true
    }
}
