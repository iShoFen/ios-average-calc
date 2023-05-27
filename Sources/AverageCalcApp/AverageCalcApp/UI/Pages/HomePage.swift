//
//  HomePage.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcViewModel
import AverageCalcStub

struct HomePage: View {
    @ObservedObject var blocksVM: BlocksVM
    @ObservedObject var uesVM: UEsVM
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    BlocksView(blocksVM: blocksVM)
                    Divider()
                    UEsView(uesVM: uesVM)
                    
            }
            .navigationTitle("Calculette")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let blocksVM = BlocksVM(withBlock: loadAllBlocks())
        let uesVM = UEsVM(withUEs: loadAllUEs())
        HomePage(blocksVM: blocksVM, uesVM: uesVM)
    }
}
