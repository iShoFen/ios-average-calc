//
//  BlocksView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel
import AverageCalcViewModel

struct BlocksView: View {
    @ObservedObject var ucaVM: UCAVM
    
    @State private var newBlockVM = BlockVM(fromBlock: Block(name: "Nouveau Bloc", ues: []))
    
    @State private var isNewBlock = false
    @State private var isBlockError = false
    @State private var isUEError = false
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Label("Blocs", systemImage: "doc.on.doc.fill")
                    .font(.title)
                
                Button {
                    isNewBlock = true
                    newBlockVM.onEditing()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            
            Text("Vous devez avoir la moyenne à chaque de ces blocs pour avoir votre diplôme.")
            
            ForEach(ucaVM.blocks) { block in
                HStack {
                    if block.name == "Total" {
                        Image(systemName: "minus")
                            .foregroundColor(CalcColors.lightGrey)
                    } else {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                _ = ucaVM.remove(block: block)
                            }
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                    
                    BlockItemView(blockVM: BlockVM(fromBlock: block))
                        .padding(.vertical, 8)
                    
                    NavigationLink(destination: BlockDetailPage(blockVM: BlockVM(fromBlock: block), ucaVM: ucaVM)) {
                        Image(systemName: "square.and.pencil")
                    }
                }
            }

        }
        .padding(32)
        .background(CalcColors.lightGrey)
        .cornerRadius(8)
        .padding(8)
        .sheet (isPresented: $isNewBlock, onDismiss: {
            isNewBlock = false
            createNewBlock(&newBlockVM)
        }) {
            NavigationStack {
            
                BlockEditView(blockData: $newBlockVM.model, ucaVM: ucaVM)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isBlockError = !ucaVM.checkBlockNameAvailability(of: newBlockVM.model)
                                
                                if !isBlockError {
                                    
                                    newBlockVM.model.ues.forEach { ue in
                                        isUEError = !ucaVM.checkUENameAvailability(of: ue)
                                        if isUEError {
                                            return
                                        }
                                    }
                                    
                                    if !isUEError {
                                        _ = newBlockVM.onEdited()
                                        _ = ucaVM.update(with: newBlockVM)
                                        isNewBlock = false
                                        createNewBlock(&newBlockVM)
                                    }
                                }
                            }
                            .alert("Le nom du Block est déjà utilisé par une autre. Veuillez le modifier afin de pouvoir sauvegarder les changements !", isPresented: $isBlockError) {
                                Button("OK", role: .cancel) {}
                            }
                            .alert("Le nom d'une de vos UEs est déjà utilisé par une autre. Veuillez le modifier afin de pouvoir sauvegarder les changements !", isPresented: $isUEError) {
                                Button("OK", role: .cancel) {}
                            }
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                _ = newBlockVM.onEdited(isCancelled: true)
                                isNewBlock = false
                                createNewBlock(&newBlockVM)
                            }
                        }
                    }
            }
        }
    }
    
    private func createNewBlock( _ block: inout BlockVM) {
        block = BlockVM(fromBlock: Block(name: "Nouveau Bloc", ues: []))
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
