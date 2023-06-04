//
//  UEDetailPage.swift
//  UCAverageApp
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct UEDetailPage: View {
    @ObservedObject var ueVM: UEVM
    @State private var isError = false
    @State private var error = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                UEItemView(ueVM: ueVM)

                VStack(alignment: .leading, spacing: 8) {
                    Label("coefficient : \(ueVM.coefficient.format(f: ".1"))", systemImage: "xmark.circle.fill")
                    Label("Détails des notes", systemImage: "note.text")
                }

                CoursesView(ueVM: ueVM)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
        .navigationTitle(ueVM.name)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    ueVM.onEditing()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $ueVM.isEditing, onDismiss: {
            _ = ueVM.onEdited(isCanceled: true, error: &error)
        }) {
            NavigationStack {
                UEEditView(ueVM: ueVM.copy!)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isError = !ueVM.onEdited(error: &error)
                            }
                            .alert(error, isPresented: $isError) {
                                Button("OK", role: .cancel) {}
                            }
                        }
                        
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                    _ = ueVM.onEdited(isCanceled: true, error: &error)
                                
                            }
                        }
                    }
            }
        }
    }
}

struct UEDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        NavigationStack {
            UEDetailPage(ueVM: ucaVM.blocks[0].ues[0])
        }
    }
}
