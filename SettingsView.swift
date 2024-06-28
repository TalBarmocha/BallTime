//
//  SettingsView.swift
//  basketball
//
//  Created by tal barmocha on 26/06/2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var settings: GameSettings

    // Define your theme colors
    

    var body: some View {
        Form {
            Section(header: Text("Timer Settings")) {
                Stepper(value: $settings.timerDuration, in: 60...3600, step: 60) {
                    Text("Duration: \(settings.timerDuration / 60) minutes")
                }
                .onChange(of: settings.timerDuration) {
                    settings.timeRemaining=settings.timerDuration
                }
            }

            Section(header: Text("Points Settings")) {
                Stepper(value: $settings.pointsToAdd, in: 1...10) {
                    Text("Points to Add: \(settings.pointsToAdd)")
                }
                Stepper(value: $settings.threePointerPoints, in: 2...10) {
                    Text("Three Pointer Points: \(settings.threePointerPoints)")
                }
                Stepper(value: $settings.winningScore, in: 1...100) {
                    Text("Winning Score: \(settings.winningScore)")
                }
                Toggle("Extended Winning Rule", isOn: $settings.useExtendedWinningRule)
            }

            Section(header: Text("Team Colors")) {
                CustomColorPicker(title: "Team 1 Color", selectedColor: $settings.team1Color, colorOptions: settings.themeColors)
                CustomColorPicker(title: "Team 2 Color", selectedColor: $settings.team2Color, colorOptions: settings.themeColors)
            }
        }
        .navigationBarTitle("Settings")
    }
}

#Preview {
    SettingsView(settings: GameSettings())
}

