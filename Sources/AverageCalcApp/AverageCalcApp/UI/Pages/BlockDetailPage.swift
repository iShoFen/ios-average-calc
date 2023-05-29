//
//  BlockDetailPage.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct BlockDetailPage: View {
    @ObservedObject var blockVM: BlockVM
    @ObservedObject var ucaVM: UCAVM

    @State private var blockError = false
    
    var body: some View {
        ScrollView {
            let blockVM2 = BlockVM(fromBlock: ucaVM.blocks.first(where: { $0.id == blockVM.original.id })!)
            VStack(alignment: .leading, spacing: 32) {
                BlockItemView(blockVM: blockVM2)
                    .font(.title3)
                
                Divider()
                
                Label("Détails des UEs", systemImage: "note.text")
                
                UEsView(blockVM: blockVM2, ucaVM: ucaVM)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
        .navigationTitle(blockVM.original.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    blockVM.onEditing()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $blockVM.isEditing, onDismiss: {
            _ = blockVM.onEdited(isCancelled: true)
        }) {
            NavigationStack {
                Text("Block edition")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                blockError = !ucaVM.checkBlockNameAvailability(of: blockVM.model)
                                
                                if !blockError {
                                    _ = blockVM.onEdited()
                                    _ = ucaVM.update(with: blockVM)
                                }
                            }
                            .alert("Le nom du Block est déjà utilisé par une autre. Veuillez le modifier afin de pouvoir sauvegarder les changements !", isPresented: $blockError) {
                                        Button("OK", role: .cancel) {}
                                    }
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                _ = blockVM.onEdited(isCancelled: true)

                            }
                        }
                    }
            }
        }
    }
}

struct BlockDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        let blockVM = BlockVM(fromBlock: ucaVM.blocks[0])
        NavigationStack {
            BlockDetailPage(blockVM: blockVM, ucaVM: ucaVM)
        }
    }
}
