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
    @StateObject var uesVM = UEsVM(withUEs: loadAllUEs())
    @StateObject var blocksVM = BlocksVM(withBlock: loadAllBlocks())
    
    var body: some Scene {
        WindowGroup {
            HomePage(blocksVM: blocksVM, uesVM: uesVM)
        }
    }
}
