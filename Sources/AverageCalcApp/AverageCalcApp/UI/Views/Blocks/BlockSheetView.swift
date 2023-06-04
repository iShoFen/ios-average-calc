//
//  BlockSheetView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct BlockSheetView: View {
    @ObservedObject var blockVM: BlockVM
    @ObservedObject var ucaVM: UCAVM
    
    @State private var isBlockError = false
    @State private var isUEError = false
    
    
    var body: some View {
        NavigationStack {
            BlockEditView(blockData: $blockVM.model, ucaVM: ucaVM)
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Done") {
                            isBlockError = !ucaVM.checkBlockNameAvailability(of: blockVM.model)
                            
                            if !isBlockError {
                                
                                blockVM.model.ues.forEach { ue in
                                    isUEError = !ucaVM.checkUENameAvailability(of: ue)
                                    if isUEError {
                                        return
                                    }
                                }
                                
                                if !isUEError {
                                    _ = blockVM.onEdited()
                                    _ = ucaVM.update(with: blockVM)
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
                            _ = blockVM.onEdited(isCancelled: true)

                        }
                    }
                }
        }
    }
}

struct BlockSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        let blockVM = BlockVM(fromBlock: ucaVM.blocks[0])
        BlockSheetView(blockVM: blockVM, ucaVM: ucaVM)
    }
}
