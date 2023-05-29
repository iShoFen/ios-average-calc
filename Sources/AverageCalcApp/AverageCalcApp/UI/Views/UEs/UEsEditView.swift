//
//  UEsEditView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct UEsEditView: View {
    @Binding var blockData: Block.Data
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach($blockData.ues) { $ue in
                HStack(spacing: 16) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if let index = blockData.ues.firstIndex(where: { $0.id == ue.id }) {
                                blockData.ues.remove(at: index)
                            }
                        }
                    }
                    label: {
                        Image(systemName: "minus")
                    }

                    UEEditItemView(ueData: $ue)
                }
            }
        }
        .padding(8)
    }
}

struct UEsEditView_Previews: PreviewProvider {
    static var previews: some View {
        let blockData = loadAllBlocks()[0].data
        UEsEditView(blockData: .constant(blockData))
    }
}
