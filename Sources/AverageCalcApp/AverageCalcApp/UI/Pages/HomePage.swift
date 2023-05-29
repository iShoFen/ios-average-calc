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
    @ObservedObject var ucaVM: UCAVM

    var body: some View {
        NavigationStack {
            ScrollView {
                BlocksView(ucaVM: ucaVM)
                Divider()

                let totalIndex = ucaVM.blocks.firstIndex(where: { $0.name == "Total" })!
                UEsView(blockVM: BlockVM(fromBlock: ucaVM.blocks[totalIndex]), ucaVM: ucaVM)
                    .background(CalcColors.lightGrey)
                    .cornerRadius(8)
                    .padding(8)
            }
            .navigationTitle("Calculette")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        HomePage(ucaVM: ucaVM)
    }
}
