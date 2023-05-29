//
//  CoursesView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 27/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct CoursesView: View {
    @ObservedObject var ueVM: UEVM
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(ueVM.original.courses) { course in
                CourseItemView(courseVM: CourseVM(fromCourse: course), ueVM: ueVM)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        let ueVM = UEVM(fromUE: loadAllBlocks()[0].ues[0])
        CoursesView(ueVM: ueVM)
    }
}
