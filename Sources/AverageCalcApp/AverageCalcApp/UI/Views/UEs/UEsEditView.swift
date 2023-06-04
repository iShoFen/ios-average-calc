//
//  UEsEditView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct UEsEditView: View {
    @ObservedObject var blockVM: BlockVM
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(blockVM.ues) { ueVM in
                HStack(spacing: 16) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if let index = blockVM.ues.firstIndex(where: { $0 == ueVM }) {
                                blockVM.ues.remove(at: index)
                            }
                        }
                    }
                    label: {
                        Image(systemName: "minus")
                    }

                    UEEditItemView(ueVM: ueVM)
                }
            }
        }
        .padding(8)
    }
}

struct UEsEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        UEsEditView(blockVM: ucaVM.blocks[0])
    }
}
