//
//  GameSettings.swift
//  basketball
//
//  Created by tal barmocha on 26/06/2024.
//

import Foundation
import SwiftUI

class GameSettings: ObservableObject {
    @Published var team1Score: Int = 0
    @Published var team2Score: Int = 0
    @Published var timerDuration: Int = 600 // default 10 minutes
    @Published var timeRemaining: Int = 600 // default 10 minutes
    @Published var pointsToAdd: Int = 2 {
        didSet {
            if threePointerPoints <= pointsToAdd {
                threePointerPoints = pointsToAdd + 1
            }
        }
    }
    @Published var threePointerPoints: Int = 3 {
        didSet {
            if threePointerPoints <= pointsToAdd {
                pointsToAdd =  threePointerPoints - 1
            }
        }
    }
    @Published var team1Color: Color = Color("pastel5"){
        didSet {
            if team1Color == team2Color {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.team1Color = self.themeColors.randomElement() ?? self.team2Color}
            }
        }
    }
    @Published var team2Color: Color = Color("pastel1"){
        didSet {
            if team2Color == team1Color {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    self.team2Color = self.themeColors.randomElement() ?? self.team1Color}
            }
        }
    }
    @Published var winningScore: Int = 11 // default winning score
    @Published var useExtendedWinningRule: Bool = true // default to true
    
    let themeColors: [Color] = [
        Color("pastel1"),
        Color("pastel2"),
        Color("pastel3"),
        Color("pastel4"),
        Color("pastel5"),
        Color("pastel6"),
        Color("pastel7"),
    ]


}
