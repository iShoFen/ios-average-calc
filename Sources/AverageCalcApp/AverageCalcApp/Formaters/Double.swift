//
//  Double.swift
//  AverageCalcApp
//
//  Created by etudiant on 25/05/2023.
//

import Foundation

extension Double {
    func format(f: String) -> String {
        String(format: "%\(f)f", self)
    }
}
