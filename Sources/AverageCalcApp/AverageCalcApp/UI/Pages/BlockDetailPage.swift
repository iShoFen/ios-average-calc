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
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var ucaVM: UCAVM
    @ObservedObject var blockVM: BlockVM

    @State private var isError = false
    @State private var error = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                BlockItemView(blockVM: blockVM)
                    .font(.title3)
                
                Divider()
                
                Label("Détails des UEs", systemImage: "note.text")
                
                UEsView(ucaVM: ucaVM)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
        .navigationBarBackButtonHidden(true)
        .navigationTitle(blockVM.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    ucaVM.selectedBlock = ucaVM.blocks[ucaVM.totalIndex]
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    HStack {
                       Image(systemName: "chevron.left")
                       Text("Calculette")
                   }
                }
            }
            ToolbarItem(placement: .primaryAction) {
                Button {
                    blockVM.onEditing()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $blockVM.isEditing, onDismiss: {
            _ = blockVM.onEdited(isCanceled: true, error: &error)
        }) {
            NavigationStack {
                BlockEditView(blockVM: blockVM.copy!, ucaVM: ucaVM)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isError = !blockVM.onEdited(error: &error)
                            }
                            .alert(error, isPresented: $isError) {
                                Button("OK", role: .cancel) {}
                            }
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                _ = blockVM.onEdited(isCanceled: true, error: &error)

                            }
                        }
                    }
            }
        }
    }
}

struct BlockDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        NavigationStack {
            BlockDetailPage(ucaVM: ucaVM, blockVM: ucaVM.blocks[0])
        }
    }
}
