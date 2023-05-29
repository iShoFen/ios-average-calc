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
    @ObservedObject var ucaVM: UCAVM
    
    var body: some View {
        LazyVStack(alignment: .leading) {
            Label("UEs", systemImage: "doc.fill")
                .font(.title)
            Text("Détail des UEs")

            let totalIndex = ucaVM.blocks.firstIndex(where: { $0.name == "Total" })!
            ForEach(ucaVM.blocks[totalIndex].ues) { ue in
                HStack {
                    UEItemView(ueData: ue.data)
                    NavigationLink(destination: UEDetailPage(ueVM: UEVM(fromUE: ue), ucaVM: ucaVM)) {
                        Image(systemName: "square.and.pencil")
                    }
                    Divider()
                }
            }
        }
        .padding(32)

    }
}

struct UEsView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(withBlock: loadAllBlocks())
        UEsView(ucaVM: ucaVM)
    }
}
