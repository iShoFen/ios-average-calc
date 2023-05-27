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
    @ObservedObject var uesVM: UEsVM

    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 32) {
                UEItemView(ueVM: ueVM)

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
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    ueVM.onEditing()
                } label: {
                    Text("Edit")
                }
            }
        }
        .sheet(isPresented: $ueVM.isEditing) {
            NavigationStack {
                Text("Page d'édition d'un UE")
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                               _ = ueVM.onEdited()
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
        let uesVM = UEsVM(withUEs: loadAllUEs())
        let ueVM = UEVM(fromUE: uesVM.ues[0])
        NavigationStack {
            UEDetailPage(ueVM: ueVM, uesVM: uesVM)
        }
    }
}
