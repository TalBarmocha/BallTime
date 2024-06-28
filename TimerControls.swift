//
//  TimerControls.swift
//  basketball
//
//  Created by tal barmocha on 26/06/2024.
//

import SwiftUI

struct TimerControls: View {
    @ObservedObject var settings: GameSettings
    var startAction: () -> Void
    var pauseAction: () -> Void
    var resetAction: () -> Void
    var timestarted: Bool

    var body: some View {
        
        HStack {
            ZStack{
                Button(action:startAction) {
                    ZStack{
                        CircleProgressBarView(settings: settings, fraction: Double(settings.timeRemaining), whole: Double(settings.timerDuration))
                        Image(systemName: "play.fill").font(.title)
                    }
                }.opacity(timestarted ? 0: 1)
                Button(action: pauseAction) {
                    ZStack{
                        CircleProgressBarView(settings: settings, fraction: Double(settings.timeRemaining), whole: Double(settings.timerDuration))
                        Image(systemName: "pause.fill").font(.title)
                    }
                }.opacity(timestarted ? 1: 0)
            }
            .padding(.horizontal,5)
            
            
            Button(action: resetAction) {
                ZStack{
                    CircleProgressBarView(settings: settings, fraction: 1.0, whole: 1.0)
                    Image(systemName: "stop.fill").font(.title)
                }
            }
            .padding(.horizontal,5)
        }.foregroundStyle(Color(.orange))
    }
}

#Preview {
    TimerControls(settings:GameSettings(),startAction: { print("Start") }, pauseAction: { print("Pause") }, resetAction: { print("Reset") },timestarted: false)
}
