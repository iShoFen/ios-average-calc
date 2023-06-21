//
// Created by etudiant on 04/06/2023.
//

import Foundation

public class BaseVM: ObservableObject, Identifiable {
    var updateFuncs: [AnyHashable:(BaseVM) -> ()] = [:]

    var validationFuncs: [AnyHashable:(BaseVM, inout String) -> Bool] = [:]

    public func subscribeUpdate(with obj: AnyHashable, and function:@escaping (BaseVM) -> ()) {
        updateFuncs[obj] = function
    }
    
    public func unsubscribeUpdate(with obj: AnyHashable) {
        updateFuncs.removeValue(forKey: obj)
    }

    public func subscribeValidation(with obj: AnyHashable,and function: @escaping (BaseVM, inout String) -> Bool) {
        validationFuncs[obj] = function
    }

    public func unsubscribeValidation(with obj: AnyHashable) {
        validationFuncs.removeValue(forKey: obj)
    }

    func onModelChanged() {
        for kvp in updateFuncs {
            kvp.value(self)
        }
    }

    func onValidating(_ copy: BaseVM, _ message: inout String) -> Bool {
        for kvp in validationFuncs {
            if !kvp.value(copy, &message) {
                return false
            }
        }
        return true
    }
}
