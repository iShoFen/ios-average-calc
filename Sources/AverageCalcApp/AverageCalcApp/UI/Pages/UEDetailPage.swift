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
    @ObservedObject var ucaVM : UCAVM
    @State private var coursesError = false
    @State private var ueError = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                UEItemView(ueData: ueVM.original.data)

                VStack(alignment: .leading, spacing: 8) {
                    Label("coefficient : \(ueVM.original.coefficient.format(f: ".1"))", systemImage: "xmark.circle.fill")
                    Label("Détails des notes", systemImage: "note.text")
                }

                CoursesView(ueVM: ueVM)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical)
        .navigationTitle(ueVM.original.name)
        .onDisappear {
            _ = ucaVM.updateUE(with: ueVM)
        }
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
            _ = ueVM.onEdited(isCancelled: true)
        }) {
            NavigationStack {
                UEEditView(ueData: $ueVM.model)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                ueError = !ucaVM.checkUENameAvailability(name: ueVM.model.name)

                                if !ueError {
                                    coursesError = !ueVM.onEdited()
                                }
                            }
                            .alert("Au moins un de vos cours possède le 2 fois le même nom. Veuillez les modifier afin de pouvoir sauvegarder les changements", isPresented: $coursesError) {
                                Button("OK", role: .cancel) {}
                            }
                            .alert("Le nom de l'UE est déjà utilisé par une autre? Veuillez le modifier afin de pouvoir sauvegarder les changements", isPresented: $ueError) {
                                Button("OK", role: .cancel) {}
                            }
                        }
                        
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                    _ = ueVM.onEdited(isCancelled: true)
                                
                            }
                        }
                    }
            }
        }
    }
}

struct UEDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        let ueVM = UEVM(fromUE: ucaVM.blocks[0].ues[0])
        NavigationStack {
            UEDetailPage(ueVM: ueVM, ucaVM: ucaVM)
        }
    }
}
