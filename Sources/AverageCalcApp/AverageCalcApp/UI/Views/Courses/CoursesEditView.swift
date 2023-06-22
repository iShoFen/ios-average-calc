//
//  CoursesEditView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct CoursesEditView: View {
    @ObservedObject var ueVM: UEVM
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(ueVM.courses) { courseVM in
                HStack(spacing: 16) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if let index = ueVM.courses.firstIndex(where: { $0 == courseVM }) {
                                ueVM.courses.remove(at: index)
                            }
                        }
                    }
                    label: {
                        Image(systemName: "minus")
                    }

                    CourseEditItemView(courseVM: courseVM)
                }
            }
        }
        .padding(8)
    }
}

struct CoursesEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        CoursesEditView(ueVM: ucaVM.blocks[0].ues[0])
    }
}
