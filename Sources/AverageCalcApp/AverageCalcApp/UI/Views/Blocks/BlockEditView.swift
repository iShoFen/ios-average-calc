//
//  BlockEditView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct BlockEditView: View {
    @ObservedObject var blockVM: BlockVM
    @ObservedObject var ucaVM: UCAVM
    
    var body: some View {
        ScrollView {
            Text("Information du bloc")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
            HStack {
                Text("Nom du bloc :")
                    .bold()
                TextField("Entrez le nom du bloc", text: $blockVM.name)
                    .disabled(blockVM.name == "Total")
            }
            
            Divider()
            
            HStack {
                Text("Liste des UEs")
                    .font(.title)
                
                Menu {
                    Button {
                        blockVM.ues.append(UEVM())
                    } label: {
                        Text("Ajouter une nouvelle UE")
                    }
                    
                    let totalIndex = ucaVM.blocks.firstIndex(where: { $0.name == "Total" })!
                    ForEach(ucaVM.blocks[totalIndex].ues) { ueVM in
                        if !blockVM.ues.contains(where: { $0 == ueVM }) {
                            Button {
                                blockVM.ues.append(ueVM)
                            } label: {
                                Text(ueVM.name)
                            }
                        }
                    }
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            UEsEditView(blockVM: blockVM)
        }
        .padding(8)
    }
}

struct BlockEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        BlockEditView(blockVM: ucaVM.blocks[0], ucaVM: ucaVM)
    }
}
