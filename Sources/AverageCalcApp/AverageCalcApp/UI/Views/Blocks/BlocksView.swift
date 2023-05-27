//
//  BlocksView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct BlocksView: View {
    public var blocksVM: BlocksVM
    var body: some View {
        LazyVStack(alignment: .leading) {
            Label("Blocs", systemImage: "doc.on.doc.fill")
                .font(.title)
            Text("Vous devez avoir la moyenne à chaque de ces blocs pour avoir votre diplôme.")
            
            ForEach(blocksVM.blocks) { block in
                BlockItemView(blockVM: BlockVM(fromBlock: block))
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
        let blocks = BlocksVM(withBlock: loadAllBlocks())
        BlocksView(blocksVM: blocks)
    }
}
