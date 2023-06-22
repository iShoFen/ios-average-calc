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
            
            ForEach(ucaVM.selectedBlock.ues) { ueVM in
                HStack {
                    UEItemView(ueVM: ueVM)
                    NavigationLink(destination: UEDetailPage(ueVM: ueVM)) {
                        Image(systemName: "square.and.pencil")
                    }
                    Divider()
                }
            }
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 32)

    }
}

struct UEsView_Previews: PreviewProvider {
    static var previews: some View {
        let ucaVM = UCAVM(from: loadAllBlocks())
        UEsView(ucaVM: ucaVM)
    }
}
