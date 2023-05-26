//
//  BlockItem.swift
//  AverageCalcApp
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcModel
import AverageCalcStub

struct BlockItem: View {
    public var block: Block
    
    var body: some View {
        HStack {
            Label(block.name, systemImage: "doc.on.doc.fill")
            Spacer()
            Text(block.average.format(f: ".2"))
            Image(systemName: "graduationcap.circle.fill")
        }
    }
}

struct BlockItem_Previews: PreviewProvider {
    static var previews: some View {
        let stub = Stub()
        BlockItem(block: stub.blocks.first!)
    }
}
