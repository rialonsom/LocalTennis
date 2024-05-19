//
//  MatchViewScore.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 15-03-24.
//

import SwiftUI

struct MatchScoreView: View {
    @ObservedObject var match: Match
    
    private let sides = [PlayerSide.playerHome, PlayerSide.playerAway]
    
    var body: some View {
        let currentSet = match.currentSet
        let currentGame = currentSet?.currentGame
        let winner = match.winner
        
        VStack {
            HStack(alignment: .center) {
                // Players
                Grid(alignment: .leading, verticalSpacing: 4) {
                    ForEach(sides) { side in
                        GridRow {
                            HStack {
                                Text(getMatchPlayerName(match: match, side: side))
                                if (currentGame?.currentServe == side) {
                                    Image(systemName: "circle.fill")
                                        .resizable()
                                        .foregroundStyle(.green)
                                        .frame(width: 8, height: 8)
                                }
                            }
                        }
                        .opacity(winner != nil && winner != side ? 0.4 : 1)
                    }
                }
                
                Spacer()
                
                // Scores
                Grid(alignment: .trailing, verticalSpacing: 4) {
                    ForEach(sides) { side in
                        GridRow(alignment: .bottom) {
                            ForEach(match.sets) { set in
                                MatchSetScoreView(
                                    games: getSetGames(set: set, side: side),
                                    tiebreakPoints: set.hasTieBreak ? getSetTieBreakPoints(set: set, side: side) : nil
                                )
                                .opacity(set.winner != nil && set.winner != side ? 0.4 : 1)
                            }
                            if (currentSet != nil) {
                                Text("\(getSetGames(set: match.currentSet!, side: side))")
                                    .bold()
                            }
                            if (currentGame != nil) {
                                if (getGamePoints(
                                    game: currentGame!,
                                    side: PlayerSide.getOpponent(player: side)) == .advantage
                                ) {
                                    Text("")
                                } else {
                                    Text(getGamePoints(game: currentGame!, side: side).description)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


extension MatchScoreView {
    private func getMatchPlayerName(match: Match, side: PlayerSide) -> String {
        let paths = [
            PlayerSide.playerHome: \Match.playerHome,
            PlayerSide.playerAway: \Match.playerAway
        ]
        
        return match[keyPath: paths[side]!]
    }
    
    private func getSetGames(set: Set, side: PlayerSide) -> Int {
        let paths = [
            PlayerSide.playerHome: \Set.gamesPlayerHome,
            PlayerSide.playerAway: \Set.gamesPlayerAway
        ]
        
        return set[keyPath: paths[side]!]
    }
    
    private func getSetTieBreakPoints(set: Set, side: PlayerSide) -> Int {
        let paths = [
            PlayerSide.playerHome: \Set.tieBreakPointsPlayerHome,
            PlayerSide.playerAway: \Set.tieBreakPointsPlayerAway
        ]
        
        return set[keyPath: paths[side]!]
    }
    
    private func getGamePoints(game: Game, side: PlayerSide) -> Game.Point {
        let paths = [
            PlayerSide.playerHome: \Game.pointsPlayerHome,
            PlayerSide.playerAway: \Game.pointsPlayerAway
        ]
        
        return game[keyPath: paths[side]!]
    }
}

#Preview {
    MatchScoreView(match: Match.exampleMatchTieBreak)
}

#Preview {
    MatchScoreView(match: Match.exampleHistoryMatches[2])
}
