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
    @State private var isEditing = false
    var body: some View {
        HStack(spacing: 32) {
            Button {
                isEditing.toggle()
            } label: {
                Image(systemName: isEditing ? "lock.open" : "lock")
                    .frame(width: 32)
            }
                
            VStack {
                HStack {
                    Text(courseVM.name).padding(.leading, 10)
                    Spacer()
                    Text(String(courseVM.coefficient))
                        .padding(.trailing, 10)
                }
                
                MarkSlider(value: $courseVM.mark, isEditable: $isEditing, minValue: 0, maxValue: 20)
                    .padding(.trailing, 60)

                
                Divider()
            }
        }
    }
}

struct CourseItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        let courseVM = ucaVM.blocks[0].ues[0].courses[0]
        CourseItemView(courseVM: courseVM)
    }
}
