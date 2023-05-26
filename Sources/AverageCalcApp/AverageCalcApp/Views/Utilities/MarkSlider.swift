//
//  MarkSlider.swift
//  AverageCalcApp
//
//  Created by etudiant on 26/05/2023.
//

import SwiftUI

struct MarkSlider: View {
    @Binding var value: Double
    @Binding var locked: Bool
    let minValue: Double
    let maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                let dragGesture = DragGesture()
                    .onChanged { gesture in
                        if !locked { updateValue(gesture, geometry) }
                    }
                
                Rectangle()
                    .foregroundColor(value < maxValue/2 ? .red : .green)
                    .clipShape(Capsule())
                    .frame(width: updateWidth(geometry))
                    .gesture(dragGesture)
                
                Text(value.format(f: ".2"))
            }
            .padding(.trailing, 20)
        }
        .frame(height: 25)
    }

    private func updateWidth(_ geometry: GeometryProxy) -> CGFloat {
        let minimumWidth: CGFloat = 20
        let textWidth = getTextWidth(for: value.format(f: ".2"))
        let availableWidth = geometry.size.width - textWidth - minimumWidth
        let percentage = (value - minValue) / (maxValue - minValue)
        return max(CGFloat(percentage) * availableWidth, minimumWidth)
    }

    private func updateValue(_ gesture: DragGesture.Value, _ geometry: GeometryProxy) {
        let width = geometry.size.width
        let position = gesture.location.x
        let percentage = Double(position / width)
        let updatedValue = minValue + (maxValue - minValue) * percentage
        value = min(max(updatedValue, minValue), maxValue)
    }
        
    private func getTextWidth(for text: String) -> CGFloat {
        let font = UIFont.systemFont(ofSize: 20)
        let textAttributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: textAttributes)
        return ceil(size.width)
    }
}

struct MarkSlider_Previews: PreviewProvider {
    static var previews: some View {
        var value = 20.0
        var locked = false
        MarkSlider(value: Binding<Double>(
            get: { value },
            set: { value = $0 }
        ), locked: Binding<Bool>(
            get: { locked },
            set: { locked = $0 }
        ), minValue: 0, maxValue: 20)
    }
}
