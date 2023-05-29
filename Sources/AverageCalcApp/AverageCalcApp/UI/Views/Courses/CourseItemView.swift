//
//  CourseItemView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 27/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct CourseItemView: View {
    @ObservedObject public var courseVM: CourseVM
    @ObservedObject public var ueVM: UEVM
    
    var body: some View {
        HStack(spacing: 32) {
            Button {
                if courseVM.isEditing {
                    courseVM.onEdited()
                    ueVM.updateCourse(fromCourseVM: courseVM)
                } else {
                    courseVM.onEditing()
                }
            } label: {
                Image(systemName: courseVM.isEditing ? "lock.open" : "lock")
                    .frame(width: 32)
            }
                
            VStack {
                HStack {
                    Text(courseVM.model.name).padding(.leading, 10)
                    Spacer()
                    Text(String(courseVM.model
                    .coefficient)).padding(.trailing, 10)
                }
                
                MarkSlider(value: $courseVM.model.mark, isEditable: $courseVM.isEditing, minValue: 0, maxValue: 20)
                    .padding(.trailing, 60)

                
                Divider()
            }
        }
    }
}

struct CourseItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ueVM = UEVM(fromUE: loadAllBlocks()[0].ues[0])
        let courseVM = CourseVM(fromCourse: ueVM.original.courses[0])
        CourseItemView(courseVM: courseVM, ueVM: ueVM)
    }
}
