//
//  CourseEditItemView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct CourseEditItemView: View {
    @ObservedObject var courseVM: CourseVM
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nom du cours :")
                    .bold()
                TextField("Inserez le nom du cours", text: $courseVM.name)
            }
            HStack {
                Text("Coefficient du cours")
                    .bold()
                TextField("Inserez le coefficient du cours", value: $courseVM.coefficient, format: .number)
            }
            
            Divider()
        }
        .padding(8)
    }
}

struct CourseEditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        let courseVM = ucaVM.blocks[0].ues[0].courses[0]
        CourseEditItemView(courseVM: courseVM)
    }
}
