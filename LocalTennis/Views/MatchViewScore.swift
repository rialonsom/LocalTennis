//
//  MatchViewScore.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 15-03-24.
//

import SwiftUI

struct MatchViewScore: View {
    @EnvironmentObject var match: Match
    
    var body: some View {
        let currentSet = match.currentSet
        let currentGame = currentSet?.currentGame
        let winner = match.winner
        
        VStack {
            HStack {
                Grid(alignment: .leading) {
                    GridRow {
                        Image(systemName: "flag")
                        Text(match.playerHome)
                        if (currentGame?.currentServe == .playerHome) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                        }
                    }
                    .opacity(winner != nil && winner == .playerAway ? 0.4 : 1)

                    GridRow {
                        Image(systemName: "flag")
                        Text(match.playerAway)
                        if (currentGame?.currentServe == .playerAway) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                        }
                    }
                    .opacity(winner != nil && winner == .playerHome ? 0.4 : 1)
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
                    .opacity(winner != nil && winner == .playerAway ? 0.4 : 1)

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
                    .opacity(winner != nil && winner == .playerHome ? 0.4 : 1)
                }
            }
        }
    }
}

#Preview {
    MatchViewScore()
        .environmentObject(Match.exampleMatch)
}
