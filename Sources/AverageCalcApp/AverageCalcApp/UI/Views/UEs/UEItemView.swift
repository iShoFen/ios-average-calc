//
//  UEItemView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct UEItemView: View {
    public var ueData: UE.Data
    
    var body: some View {
        VStack {
            HStack {
                Text(ueData.name).padding(.leading, 10)
                Spacer()
                Text(String(ueData.coefficient)).padding(.trailing, 10)
            }
            
            MarkSlider(value: .constant(ueData.average), isEditable: .constant(false), minValue: 0, maxValue: 20)
                .padding(.trailing, 60)
            
            Divider()
        }
    }
}

struct UEItemView_Previews: PreviewProvider {
    static var previews: some View {
        let ueData = loadAllBlocks()[0].ues[0].data
        UEItemView(ueData: ueData)
    }
}
