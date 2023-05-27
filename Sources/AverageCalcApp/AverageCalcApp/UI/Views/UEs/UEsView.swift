//
//  UEsView.swift
//  AverageCalcApp
//
//  Created by Samuel SIRVEN on 25/05/2023.
//

import SwiftUI
import AverageCalcStub
import AverageCalcViewModel

struct UEsView: View {
    public var uesVM: UEsVM
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Label("UEs", systemImage: "doc.fill")
                .font(.title)
            Text("Détail des UEs")

            ForEach(uesVM.ues) { ue in
                HStack(spacing: 8) {
                    UEItemView(ueVM: UEVM(fromUE: ue))
                    NavigationLink(destination: Text(ue.name)) {
                        Image(systemName: "square.and.pencil")
                    }
                    Divider()
                }
            }
        }
        .padding(32)
        .background(CalcColors.lightGray)
        .cornerRadius(8)
        .padding(8)
    }
}

struct UEsView_Previews: PreviewProvider {
    static var previews: some View {
        let uesVM = UEsVM(withUEs: loadAllUEs())
        UEsView(uesVM: uesVM)
    }
}
