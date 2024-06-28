//
//  ContentView.swift
//  basketball
//
//  Created by tal barmocha on 26/06/2024.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var settings = GameSettings()
    @State private var timer: Timer? = nil
    @State private var showingWinnerPopup = false
    @State private var winnerTeam: Int?
    @State private var timestarted = false
    @State private var savedWinningsScore = 0

    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    //UPPER BAR
                    HStack {
                        Button(action: newGame) {
                            Text("New Game")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                        }
                        .padding(.horizontal)
                        Spacer()
                        HStack{
                            Text("Win: \(settings.winningScore)").font(.title3)
                            Text("pts").font(.subheadline).padding(.leading,-5).padding(.top,6)
                        }
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        NavigationLink(destination: SettingsView(settings: settings)) {
                            Image(systemName: "gearshape.fill").foregroundStyle(Color.primary).dynamicTypeSize(.xLarge)
                        }
                        .padding(5)
                        .padding(.horizontal)
                    }
                    .padding(3)
                    Spacer()
                    //TEAM1
                    ZStack{
                        
                        VStack {
                            ScoreButton(title: "+\(settings.pointsToAdd)",secondbotton: false, color: settings.team1Color) {
                                settings.team1Score += settings.pointsToAdd
                                checkForWinner()
                            }
                            .fontWeight(.bold)
                            .opacity(0.5)
                             
                            ScoreButton(title: "+\(settings.threePointerPoints)",secondbotton: true, color: settings.team1Color, action: {
                                settings.team1Score += settings.threePointerPoints
                                checkForWinner()})
                            .fontWeight(.bold)
                            .opacity(0.5)
                        }
                        .background(Color(settings.team1Color))
                        .cornerRadius(30)
                        Text("\(settings.team1Score)")
                            .font(.system(size: 120))
                            .foregroundStyle(Color.white)
                            .fontWeight(.heavy)
                            .frame(height: .leastNormalMagnitude)
                    }
                    
                    //TIMER
                    HStack {
                        ZStack{
                            Text("00:00")
                                .font(.system(size: 50,weight: .semibold))
                                .padding(.horizontal,20)
                                .padding(.vertical,5)
                                .foregroundStyle(Color.Resolved(colorSpace: .sRGB, red: 0.22, green: 0.22, blue: 0.22))
                                .dynamicTypeSize(.xLarge)
                                .padding(.leading)
                            Text(String(format: "%02d:%02d", settings.timeRemaining/60, settings.timeRemaining%60))
                                .font(.system(size: 50,weight: .semibold))
                                .padding(.horizontal,20)
                                .padding(.vertical,5)
                                .foregroundStyle(Color(.white))
                                .dynamicTypeSize(.xLarge)
                                .padding(.leading)
                        }
                        TimerControls(settings:settings,startAction: startTimer, pauseAction: pauseTimer, resetAction: resetTimer,timestarted: timestarted)
                            .padding(.trailing)
                    }
                    .background(Color.Resolved(colorSpace: .sRGB, red: 0.22, green: 0.22, blue: 0.22))
                    .cornerRadius(20)
                    
                    
                    //TEAM2
                    ZStack{
                        
                        VStack {
                            ScoreButton(title: "+\(settings.pointsToAdd)",secondbotton: false, color: settings.team2Color) {
                                settings.team2Score += settings.pointsToAdd
                                checkForWinner()
                            }
                            .fontWeight(.bold)
                            .opacity(0.5)
                             
                            ScoreButton(title: "+\(settings.threePointerPoints)",secondbotton: true, color: settings.team2Color, action: {
                                settings.team2Score += settings.threePointerPoints
                                checkForWinner()})
                            .fontWeight(.bold)
                            .opacity(0.5)
                        }
                        .background(Color(settings.team2Color))
                        .cornerRadius(30)
                        Text("\(settings.team2Score)")
                            .font(.system(size: 120))
                            .foregroundStyle(Color.white)
                            .fontWeight(.heavy)
                            .frame(height: .leastNormalMagnitude)
                    }
                }
                .padding(.horizontal,5)
                
                if showingWinnerPopup {
                    WinnerPopup(
                        winnerTeam: winnerTeam ?? 0,
                        team1Color: settings.team1Color,
                        team2Color: settings.team2Color
                    ) {
                        showingWinnerPopup = false
                        resetGame()
                    }
                }
            }
            
        }
        .onAppear {
            settings.timeRemaining = settings.timerDuration
        }
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if settings.timeRemaining > 0 {
                settings.timeRemaining -= 1
                checkForWinner()
            } else {
                timer?.invalidate()
                checkForWinner()
            }
        }
        timestarted=true
    }

    func pauseTimer() {
        timer?.invalidate()
        timestarted=false
    }

    func resetTimer() {
        timer?.invalidate()
        settings.timeRemaining = settings.timerDuration
        timestarted=false
    }

    func checkForWinner() {
        if settings.team1Score >= settings.winningScore {
            winnerTeam = 1
            showingWinnerPopup = true
            timer?.invalidate()
        } else if settings.team2Score >= settings.winningScore {
            winnerTeam = 2
            showingWinnerPopup = true
            timer?.invalidate()
        } else if settings.useExtendedWinningRule && settings.team1Score >= (settings.winningScore - settings.pointsToAdd) && settings.team2Score >= (settings.winningScore - settings.pointsToAdd) {
            if savedWinningsScore == 0{
                savedWinningsScore = settings.winningScore
            }
            settings.winningScore += settings.pointsToAdd
        } else if settings.timeRemaining <= 0 {
            if settings.team1Score > settings.team2Score {
                winnerTeam = 1
            } else if settings.team2Score > settings.team1Score {
                winnerTeam = 2
            } else {
                winnerTeam = 0 // Tie
            }
            showingWinnerPopup = true
        }
    }

    func newGame() {
        resetGame()
        showingWinnerPopup = false
    }

    func resetGame() {
        settings.team1Score = 0
        settings.team2Score = 0
        resetTimer()
        if savedWinningsScore != 0{
            settings.winningScore = savedWinningsScore
        }
    }
}

struct BasketballScoreApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#Preview {
    ContentView()
}

