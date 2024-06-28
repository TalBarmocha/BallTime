//
//  ScoreButton.swift
//  basketball
//
//  Created by tal barmocha on 26/06/2024.
//

import SwiftUI

struct ScoreButton: View {
    @StateObject private var settings = GameSettings()
    var title: String
    var secondbotton: Bool
    var color: Color
    var action: () -> Void

    var body: some View {
        GeometryReader { geometry in
            Button(action: action) {
                Text(title)
                    .font(.title3)
                    .foregroundStyle(Color(.black)).opacity(0.8)
                    .frame(width: geometry.size.width,height: secondbotton ? geometry.size.height+50 : geometry.size.height-50)
                    .padding(.bottom)
            }
            .frame(width: geometry.size.width)
            
        }
        .background(color)
        .cornerRadius(15)
    }
}


#Preview {
    VStack {
        ScoreButton(title: "+2",secondbotton: false, color: .blue, action: {})
        ScoreButton(title: "+3",secondbotton: true, color: .blue, action: {})
    }
}
