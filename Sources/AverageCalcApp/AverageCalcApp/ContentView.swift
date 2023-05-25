//
//  ContentView.swift
//  AverageCalcModel
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcModel

struct ContentView: View {
    var body: some View {
        let player = Player()
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(player.text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
