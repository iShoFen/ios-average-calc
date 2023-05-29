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
    @ObservedObject var ucaVM: UCAVM
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Label("Blocs", systemImage: "doc.on.doc.fill")
                    .font(.title)
                
                NavigationLink(destination: Text("Nouveau Block"))
                {
                    Image(systemName: "plus")
                }
            }
            
            Text("Vous devez avoir la moyenne à chaque de ces blocs pour avoir votre diplôme.")
            
            ForEach(ucaVM.blocks) { block in
                HStack {
                    BlockItemView(blockVM: BlockVM(fromBlock: block))
                        .padding(.vertical, 8)
                    
                    NavigationLink(destination: Text(block.name)) {
                        Image(systemName: "square.and.pencil")
                    }
                }
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
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        NavigationStack {
            BlocksView(ucaVM: ucaVM)
        }
    }
}
