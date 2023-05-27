//
//  CoursesView.swift
//  AverageCalcApp
//
//  Created by etudiant on 27/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct CoursesView: View {
    @ObservedObject  var ueVM: UEVM
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(ueVM.original.courses) { course in
                CourseItemView(courseVM: CourseVM(fromCourse: course))
            }
        }
        .padding(32)
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        let ueVM = UEVM(fromUE: loadAllUEs()[0])
        CoursesView(ueVM: ueVM)
    }
}
