//
//  BlockItemView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct BlockItemView: View {
    public var blockVM: BlockVM
    
    var body: some View {
        HStack {
            Label(blockVM.model.name, systemImage: "doc.on.doc.fill")
            Spacer()
            Text(blockVM.model.average.format(f: ".2"))
            Image(systemName: "graduationcap.circle.fill")
        }
    }
}

struct BlockItemView_Previews: PreviewProvider {
    static var previews: some View {
        let blockVM = BlockVM(fromBlock: loadAllBlocks().first!)
        BlockItemView(blockVM: blockVM)
    }
}
