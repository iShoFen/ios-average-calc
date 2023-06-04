//
//  CoursesEditView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 28/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct CoursesEditView: View {
    @Binding var ueData: UE.Data
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach($ueData.courses) { $course in
                HStack(spacing: 16) {
                    Button {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            if let index = ueData.courses.firstIndex(where: { $0.id == course.id }) {
                                ueData.courses.remove(at: index)
                            }
                        }
                    }
                    label: {
                        Image(systemName: "minus")
                    }

                    CourseEditItemView(courseData: $course)
                }
            }
            .onDelete { offset in
                ueData.courses.remove(atOffsets: offset)
            }
        }
        .padding(8)
    }
}

struct CoursesEditView_Previews: PreviewProvider {
    static var previews: some View {
        let ueData = loadAllBlocks()[0].ues[0].data
        CoursesEditView(ueData: .constant(ueData))
    }
}
