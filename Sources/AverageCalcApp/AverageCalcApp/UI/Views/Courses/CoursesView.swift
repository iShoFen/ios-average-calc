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
            ForEach(ueVM.courses) { courseVM in
                CourseItemView(courseVM: courseVM)
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        CoursesView(ueVM: ucaVM.blocks[0].ues[0])
    }
}
