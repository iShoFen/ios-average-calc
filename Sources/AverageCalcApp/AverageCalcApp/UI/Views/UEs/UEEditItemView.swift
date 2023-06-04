//
//  UEEditItemView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct UEEditItemView: View {
    @ObservedObject var ueVM: UEVM
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nom de l'UE:")
                    .bold()
                TextField("Entrez le nom de l'UE", text: $ueVM.name)
            }
            
            HStack {
                Text("Coefficient de l'UE:")
                    .bold()
                TextField("Entrez le coefficient de l'UE", value: $ueVM.coefficient, format: .number)
            }
            
            Divider()
        }
        .padding(8)
    }
}

struct UEEditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        UEEditItemView(ueVM: ucaVM.blocks[0].ues[0])
    }
}
