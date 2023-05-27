//
//  UEItemView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct UEItemView: View {
    @ObservedObject public var ueVM: UEVM
    
    var body: some View {
        VStack {
            HStack {
                Text(ueVM.model.name).padding(.leading, 10)
                Spacer()
                Text(String(ueVM.model.coefficient)).padding(.trailing, 10)
            }
            
            MarkSlider(value: $ueVM.model.average, isEditable: .constant(false), minValue: 0, maxValue: 20)
                .padding(.trailing, 60)
            
            Divider()
        }
    }
}

struct UEItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ueVM = UEVM(fromUE: loadAllUEs().first!)
        UEItemView(ueVM: ueVM)
    }
}
