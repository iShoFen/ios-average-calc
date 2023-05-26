//
//  BlocksView.swift
//  AverageCalcApp
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcModel
import AverageCalcStub

struct BlocksView: View {
    public var blocks: [Block]
    var body: some View {
        LazyVStack(alignment: .leading) {
            Label("Blocs", systemImage: "doc.on.doc.fill")
                .font(.title)
            Text("Vous devez avoir la moyenne à chaque de ces blocs pour avoir votre diplôme.")
            
            ForEach(blocks) { block in
                BlockItem(block: block)
            }
        }
        .padding(32)
        .background(CalcColors.lightGray)
        .cornerRadius(8)
        .padding(8)
    }
}

struct BlocksView_Previews: PreviewProvider {
    static var previews: some View {
        let stub = Stub()
        BlocksView(blocks: stub.blocks)
    }
}
