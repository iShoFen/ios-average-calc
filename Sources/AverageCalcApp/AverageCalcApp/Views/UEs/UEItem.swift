//
//  UEItem.swift
//  AverageCalcApp
//
//  Created by etudiant on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcModel

struct UEItem: View {
    public var ue: UE
    @State private var mark = 12.31
    @State private var locked = true
    var body: some View {
        VStack {
            HStack {
                Text(ue.name).padding(.leading, 10)
                Spacer()
                Text(String(ue.coefficient)).padding(.trailing, 10)
            }
            
            MarkSlider(value: $mark, locked: $locked, minValue: 0, maxValue: 20)
                .padding(.trailing, 60)
            
            Divider()
        }
    }
}

struct UEItem_Previews: PreviewProvider {
    static var previews: some View {
        let stub = Stub()
        UEItem(ue: stub.getUe(index: 0))
    }
}
