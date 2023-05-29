//
//  CourseEditItemView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct CourseEditItemView: View {
    @Binding var courseData: Course.Data
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Nom du cours :")
                    .bold()
                TextField("Inserez le nom du cours", text: $courseData.name)
            }
            HStack {
                Text("Coefficient du cours")
                    .bold()
                TextField("Inserez le coefficient du cours", value: $courseData.coefficient, format: .number)
            }
            
            Divider()
        }
        .padding(8)
    }
}

struct CourseEditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let courseData = loadAllBlocks()[0].ues[0].courses[0].data
        CourseEditItemView(courseData: .constant(courseData))
    }
}
