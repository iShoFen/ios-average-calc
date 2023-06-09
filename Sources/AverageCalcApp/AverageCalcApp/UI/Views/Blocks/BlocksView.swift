//
//  BlocksView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct BlocksView: View {
    @ObservedObject var ucaVM: UCAVM
    
    @State private var newBlockVM: BlockVM = BlockVM()
    @State private var isNewBlock = false
    @State private var isError = false
    @State private var error = ""
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            HStack {
                Label("Blocs", systemImage: "doc.on.doc.fill")
                    .font(.title)
                
                Button {
                    newBlockVM.onEditing()
                    isNewBlock = true
                    
                    print(newBlockVM.copy!.name)
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            
            Text("Vous devez avoir la moyenne à chaqu'un de ces blocs pour avoir votre diplôme.")
            
            ForEach(ucaVM.blocks) { blockVM in
                HStack {
                    if blockVM.name == "Total" {
                        Image(systemName: "minus")
                            .foregroundColor(CalcColors.lightGrey)
                    } else {
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                ucaVM.removeBlock(blockVM)
                            }
                        } label: {
                            Image(systemName: "minus")
                        }
                    }
                    
                    BlockItemView(blockVM: blockVM)
                        .padding(.vertical, 8)
                    
                    NavigationLink(destination: BlockDetailPage(ucaVM: ucaVM, blockVM: blockVM)) {
                        Image(systemName: "square.and.pencil")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        ucaVM.selectedBlock = blockVM
                    })
                }
            }

        }
        .padding(32)
        .background(CalcColors.lightGrey)
        .cornerRadius(8)
        .padding(8)
        .sheet (isPresented: $isNewBlock, onDismiss: {
            newBlockVM = BlockVM()
            isNewBlock = false
        }) {
            NavigationStack {
                BlockEditView(blockVM: newBlockVM.copy!, ucaVM: ucaVM)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isError = !newBlockVM.onEdited(error: &error)
                                if !isError {
                                    isError = !ucaVM.addBlock(newBlockVM, error: &error)
                                    if !isError { isNewBlock = false }
                                }
                            }
                            .alert(error, isPresented: $isError) {
                                Button("OK", role: .cancel) {}
                            }
                        }

                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                newBlockVM = BlockVM()
                                isNewBlock = false

                            }
                        }
                    }
            }
        }
    }
}

struct BlocksView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        NavigationStack {
            BlocksView(ucaVM: ucaVM)
        }
    }
}
