//
//  CircleProgressBarView.swift
//  University Grade Calculator
//
//  Created by tal barmocha on 25/08/2023.
//

import SwiftUI

struct CircleProgressBarView: View {
    @ObservedObject var settings: GameSettings
    var fraction: Double
    var whole: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 3)
                .opacity(0.3)
                .foregroundColor(Color.orange)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(fraction/whole))
                .stroke(style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.orange)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.spring(), value: fraction)
            
        }.frame(width: 45 , height: 45)
    }
}


struct CircleProgressBarView_Previews: PreviewProvider {
    static var previews: some View {
        CircleProgressBarView(settings:GameSettings(),fraction: 65.0,whole: 100)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

