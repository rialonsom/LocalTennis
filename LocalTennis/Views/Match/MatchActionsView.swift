//
//  MatchViewActions.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 15-03-24.
//

import SwiftUI

struct MatchActionsView: View {
    @ObservedObject var match: Match
    @State private var isShowingEndingEarlyAlert: Bool = false
    
    var body: some View {
        let isLive = match.isLive
        let isFinished = match.isFinished
        
        let playerHome = match.playerHome
        let playerAway = match.playerAway

        HStack {
            // Point to player home
            Button(action: {
                match.goToNextPoint(pointWinner: .playerHome)
            }, label: {
                Spacer()
                Text("Point to \(playerHome)")
                    .frame(height: 100)
                Spacer()
            })
            .buttonStyle(.bordered)
            .tint(.indigo)
            .disabled(!isLive)
            
            // Point to player away
            Button(action: {
                match.goToNextPoint(pointWinner: .playerAway)
            }, label: {
                Spacer()
                Text("Point to \(playerAway)")
                    .frame(height: 100)
                Spacer()
            })
            .buttonStyle(.bordered)
            .tint(.indigo)
            .disabled(!isLive)
        }
        
        // Start match
        Button(action: {
            match.start()
        }, label: {
            Spacer()
            Text("Start")
                .frame(height: 100)
            Spacer()
        })
        .buttonStyle(.bordered)
        .tint(.green)
        .disabled(isLive || isFinished)
        
        // End match
        Button(action: {
            isShowingEndingEarlyAlert = true
        }, label: {
            Spacer()
            Text("End")
                .frame(height: 100)
            Spacer()
        })
        .buttonStyle(.bordered)
        .tint(.red)
        .disabled(!isLive)
        .alert("Early ending", isPresented: $isShowingEndingEarlyAlert) {
            Button(action: {
                match.end(matchWinner: .playerHome)
            }, label: {
                Text(match.playerHome)
            })
            Button(action: {
                match.end(matchWinner: .playerAway)
            }, label: {
                Text(match.playerAway)
            })
            Button(role: .cancel, action: {}, label: {
                Text("Cancel")
            })
        } message: {
            Text("Select which player should be declared winner.")
        }
    }
}

#Preview {
    MatchActionsView(match: Match.exampleMatch)
}
