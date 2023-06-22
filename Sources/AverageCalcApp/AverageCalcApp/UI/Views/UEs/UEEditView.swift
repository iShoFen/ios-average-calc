//
//  UEEditView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct UEEditView: View {
    @ObservedObject var ueVM: UEVM
    
    var body: some View {
        ScrollView {
            Text("Information de l'UE")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)
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
            
            HStack {
                Text("Liste des Cours")
                    .font(.title)
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        ueVM.courses.append(CourseVM())
                    }
                } label: {
                    Image(systemName: "plus")
                }
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            CoursesEditView(ueVM: ueVM)
            
            Spacer()
        }
        .padding(8)
    }
}

struct UEEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        UEEditView(ueVM: ucaVM.blocks[0].ues[0])
    }
}
