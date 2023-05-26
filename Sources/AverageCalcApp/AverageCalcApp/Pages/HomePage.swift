//
//  ContentView.swift
//  AverageCalcModel
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcModel
import AverageCalcStub

struct HomePage: View {
    public var stub: Stub
    
    var body: some View {
        NavigationStack {
                ScrollView {
                    BlocksView(blocks: stub.blocks)
                    Divider()
                    UEsView(ues: stub.getAllUEs())
                    
            }
            .navigationTitle("Calculette")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let stub = Stub()
        HomePage(stub: stub)
    }
}
