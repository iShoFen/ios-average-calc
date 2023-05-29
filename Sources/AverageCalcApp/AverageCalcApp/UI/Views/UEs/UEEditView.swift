//
//  UEEditView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct UEEditView: View {
    @Binding var ueData: UE.Data
    
    var body: some View {
        ScrollView(alignment: .leading) {
            Text("Information de l'UE")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
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
            
            HStack {
                Text("Liste des Cours")
                    .font(.title)
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        let course = Course(name: "Nouveau Cours", mark: 0, coefficient: 1)
                        ueData.courses.append(course.data)
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            CoursesEditView(ueData: $ueData)
            
            Spacer()
        }
        .padding(8)
    }
}

struct UEEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ueData = loadAllBlocks()[0].ues[0].data
        UEEditView(ueData: .constant(ueData))
    }
}
