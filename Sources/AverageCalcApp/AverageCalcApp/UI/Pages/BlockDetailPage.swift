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

    @State private var isError = false
    @State private var error = ""
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                BlockItemView(blockVM: blockVM)
                    .font(.title3)
                
                Divider()
                
                Label("Détails des UEs", systemImage: "note.text")
                
                UEsView(blockVM: blockVM)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
        .navigationTitle(blockVM.name)
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
            BlockDetailPage(blockVM: ucaVM.blocks[0], ucaVM: ucaVM)
        }
    }
}
