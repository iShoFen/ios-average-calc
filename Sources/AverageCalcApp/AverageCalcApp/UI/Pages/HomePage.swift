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
                UEsView(ucaVM: ucaVM)
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
