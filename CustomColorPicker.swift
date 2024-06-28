//
//  CustomColorPicker.swift
//  basketball
//
//  Created by tal barmocha on 27/06/2024.
//

import SwiftUI

struct CustomColorPicker: View {
    let title: String
    @Binding var selectedColor: Color
    let colorOptions: [Color]

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            
            HStack {
                ForEach(colorOptions, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 40, height: 40)
                        .overlay(
                            Circle()
                                .stroke(selectedColor == color ? color : Color.clear, lineWidth: 5)
                                .stroke(selectedColor == color ? Color.white : Color.clear, lineWidth: 1)
                        )
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        }
    }
}
