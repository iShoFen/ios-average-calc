//
//  UEEditItemView.swift
//  AverageCalcApp
//
//  Created by etudiant on 29/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct UEEditItemView: View {
    @Binding var ueData: UE.Data
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nom de l'UE:")
                    .bold()
                TextField("Entrez le nom de l'UE", text: $ueData.name)
            }
            
            HStack {
                Text("Coefficient de l'UE:")
                    .bold()
                TextField("Entrez le coefficient de l'UE", value: $ueData.coefficient, format: .number)
            }
            
            Divider()
        }
        .padding(8)
    }
}

struct UEEditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ueData = loadAllBlocks()[0].ues[0].data
        UEEditItemView(ueData: .constant(ueData))
    }
}
