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
                
                VStack(alignment: .leading) {
                    VStack {
                        Label("UEs", systemImage: "doc.fill")
                            .font(.title)
                        Text("Détail des UEs")
                    }
                    .padding(.horizontal, 32)
                    .padding(.top, 32)
                
                    
                    UEsView(ucaVM: ucaVM)
                }
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
        let ucaVM = UCAVM(from: loadAllBlocks())
        HomePage(ucaVM: ucaVM)
    }
}
