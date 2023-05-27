//
//  UEsVM.swift
//  AverageCalcViewModel
//
//  Created by Samuel SIRVEN on 26/05/2023.
//

import Foundation
import AverageCalcModel

public class UEsVM: ObservableObject {
    @Published
    public var ues: [UE] = []

    public init(withUEs ues: [UE]) {
        self.ues = ues
    }

    public func update(with ue: UEVM) {
        if let index = ues.firstIndex(where: { $0.id == ue.original.id }) {
            ues[index] = ue.original
        } else {
            ues.append(ue.original)
        }
    }
}
