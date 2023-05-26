//
//  UEsView.swift
//  AverageCalcApp
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcModel
import AverageCalcStub

struct UEsView: View {
    public var ues: [UE]
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Label("UEs", systemImage: "doc.fill")
                .font(.title)
            Text("Détail des UEs")

            ForEach(ues) { ue in
                HStack(spacing: 8) {
                    UEItem(ue: ue)
                    NavigationLink(destination: Text(ue.name)) {
                        Image(systemName: "square.and.pencil")
                    }
                    Divider()
                }
            }
        }
        .padding(32)
        .background(CalcColors.lightGray)
        .cornerRadius(8)
        .padding(8)
    }
}

struct UEsView_Previews: PreviewProvider {
    static var previews: some View {
        let stub = Stub()
        UEsView(ues: stub.getAllUEs())
    }
}
