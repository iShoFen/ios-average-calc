//
//  AverageCalcApp.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

@main
struct UCAverageApp: App {
    @StateObject var ucaVM = UCAVM(from: loadAllBlocks())
    
    var body: some Scene {
        WindowGroup {
            HomePage(ucaVM: ucaVM)
        }
    }
}
