//
//  MatchViewActions.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 15-03-24.
//

import SwiftUI

struct MatchViewActions: View {
    @EnvironmentObject var match: Match
    
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
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
                    .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
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
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Spacer()
        })
        .buttonStyle(.bordered)
        .tint(.green)
        .disabled(isLive || isFinished)
        
        // End match
        Button(action: {
            match.end(matchWinner: .playerHome)
        }, label: {
            Spacer()
            Text("End")
                .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            Spacer()
        })
        .buttonStyle(.bordered)
        .tint(.red)
        .disabled(!isLive)
    }
}

#Preview {
    MatchViewActions()
        .environmentObject(Match.exampleMatch)
}
