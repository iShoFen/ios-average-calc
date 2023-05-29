//
//  BlockEditView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel
import AverageCalcViewModel

struct BlockEditView: View {
    @Binding var blockData: Block.Data
    @ObservedObject var ucaVM : UCAVM
    
    var body: some View {
        ScrollView {
            Text("Information du bloc")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Text("Nom du bloc :")
                    .bold()
                TextField("Entrez le nom du bloc", text: $blockData.name)
                    .disabled(blockData.name == "Total")
            }
            
            Divider()
            
            HStack {
                Text("Liste des UEs")
                    .font(.title)
                
                Menu {
                    Button {
                        blockData.ues.append(UE(name: "Nouvelle UE", coefficient: 1, courses: []).data)
                    } label: {
                        Text("Ajouter une nouvelle UE")
                    }
                    
                    let totalIndex = ucaVM.blocks.firstIndex(where: { $0.name == "Total" })!
                    ForEach(ucaVM.blocks[totalIndex].ues) { ue in
                        if !blockData.ues.contains(where: { $0.id == ue.id }) {
                            Button {
                                blockData.ues.append(ue.data)
                            } label: {
                                Text(ue.name)
                            }
                        }
                    }
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            UEsEditView(blockData: $blockData)
        }
        .padding(8)
    }
}

struct BlockEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        let blockData = ucaVM.blocks[1].data
        BlockEditView(blockData: .constant(blockData), ucaVM: ucaVM)
    }
}
