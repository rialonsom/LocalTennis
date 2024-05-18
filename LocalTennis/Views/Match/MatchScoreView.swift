//
//  MatchViewScore.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 15-03-24.
//

import SwiftUI

struct MatchScoreView: View {
    @ObservedObject var match: Match
    
    var body: some View {
        let currentSet = match.currentSet
        let currentGame = currentSet?.currentGame
        let winner = match.winner
        
        VStack {
            HStack {
                // Players
                Grid(alignment: .leading) {
                    GridRow {
                        Text(match.playerHome)
                        if (currentGame?.currentServe == .playerHome) {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .frame(width: 8, height: 8)
                        }
                    }
                    .opacity(winner != nil && winner == .playerAway ? 0.4 : 1)

                    GridRow {
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

                // Scores
                Grid(alignment: .center) {
                    // Player home
                    GridRow {
                        ForEach(match.sets) { set in
                            Text("\(set.gamesPlayerHome)")
                                .bold()
                                .opacity(set.winner != nil && set.winner == .playerAway ? 0.4 : 1)
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

                    // Player away
                    GridRow {
                        ForEach(match.sets) { set in
                            Text("\(set.gamesPlayerAway)")
                                .bold()
                                .opacity(set.winner != nil && set.winner == .playerHome ? 0.4 : 1)
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
        }
    }
}

#Preview {
    MatchScoreView(match: Match.exampleMatch)
}

#Preview {
    MatchScoreView(match: Match.exampleHistoryMatches[2])
}
