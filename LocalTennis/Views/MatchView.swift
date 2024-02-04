//
//  MatchRow.swift
//  TennisSync
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import SwiftUI

struct MatchView: View {
    @EnvironmentObject var match: Match
    
    var body: some View {
        let isLive = match.isLive
        let isFinished = match.isFinished
        let currentSet = match.currentSet
        let currentGame = currentSet?.currentGame
        
        VStack {
            HStack {
                Grid(alignment: .leading) {
                    GridRow {
                        Image(systemName: "flag")
                        Text(match.playerHome.name)
                        if (currentGame?.currentServe == .playerHome) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                        }
                    }
                    GridRow {
                        Image(systemName: "flag")
                        Text(match.playerAway.name)
                        if (currentGame?.currentServe == .playerAway) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                        }
                    }
                }
                Spacer()
                Grid(alignment: .center) {
                    GridRow {
                        ForEach(match.sets) { set in
                            Text("\(set.gamesPlayerHome)")
                                .bold()
                            if (set.hasTieBreak) {
                                Text("(\(set.tieBreakPointsPlayerHome))")
                            }
                        }
                        if (currentSet != nil) {
                            Text("\(match.currentSet!.gamesPlayerHome)")
                                .bold()
                        }
                        if (currentGame != nil) {
                            if (currentGame!.pointsPlayerAway == .advantage) {
                                Text("")
                            } else {
                                Text(currentGame!.pointsPlayerHome.description)
                            }
                        }
                    }
                    GridRow {
                        ForEach(match.sets) { set in
                            Text("\(set.gamesPlayerAway)")
                                .bold()
                            if (set.hasTieBreak) {
                                Text("(\(set.tieBreakPointsPlayerAway))")
                            }
                        }
                        if (currentSet != nil) {
                            Text("\(currentSet!.gamesPlayerAway)")
                                .bold()
                        }
                        if (currentGame != nil) {
                            if (currentGame!.pointsPlayerHome == .advantage) {
                                Text("")
                            } else {
                                Text(currentGame!.pointsPlayerAway.description)
                            }
                        }
                    }
                }
            }
            Button("+ Home") {
                match.goToNextPoint(pointWinner: .playerHome)
            }
            .disabled(!isLive)
            Button("+ Away") {
                match.goToNextPoint(pointWinner: .playerAway)
            }
            .disabled(!isLive)
            Button("Start") {
                match.start()
            }
            .disabled(isLive || isFinished)
            Button("End") {
                match.end()
            }
            .disabled(!isLive)
        }
    }
}

#Preview {
    let match = Match.exampleMatchNew
    
    return MatchView()
        .environmentObject(match)
}
