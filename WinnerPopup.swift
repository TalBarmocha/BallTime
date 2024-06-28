//
//  WinnerPopup.swift
//  basketball
//
//  Created by tal barmocha on 26/06/2024.
//

import SwiftUI

struct WinnerPopup: View {
    var winnerTeam: Int
    var team1Color: Color
    var team2Color: Color
    var onClose: () -> Void

    var body: some View {
        ZStack{
            VStack {
                Text("Team \(winnerTeam) Wins!\n\n🥳")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()

                Button(action: onClose) {
                    Text("Close")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background((winnerTeam == 1) ? team1Color : team2Color)
                        .cornerRadius(10)
                }
                .padding()
            }.opacity(winnerTeam>0 ? 1: 0)
            VStack {
                Text("It's A Tie")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding()

                Button(action: onClose) {
                    Text("Close")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(.black))
                        .cornerRadius(10)
                }
                .padding()
            }.opacity(winnerTeam>0 ? 0: 1)
        }
        .frame(maxWidth: .infinity, maxHeight: 650)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 20, height: 10)))
    }
}

#Preview {
    WinnerPopup(winnerTeam: 1,team1Color: Color.blue,team2Color: Color.red, onClose: {})
}

