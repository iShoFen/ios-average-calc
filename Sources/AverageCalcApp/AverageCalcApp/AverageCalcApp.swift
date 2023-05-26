//
//  AverageCalcModel.swift
//  AverageCalcModel
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcStub

@main
struct UCAverageApp: App {
    var body: some Scene {
        WindowGroup {
            let stub = Stub()
            HomePage(stub: stub)
        }
    }
}
