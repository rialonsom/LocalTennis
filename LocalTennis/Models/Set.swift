//
//  Set.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import Foundation

struct Set: Identifiable, Codable {
    let id: Int
    
    private(set) var gamesPlayerHome: Int = 0
    private(set) var gamesPlayerAway: Int = 0
    
    private(set) var hasTieBreak: Bool = false
    
    private(set) var tieBreakPointsPlayerHome: Int = 0
    private(set) var tieBreakPointsPlayerAway: Int = 0
    
    private(set) var currentGame: Game?
    
    var isLive: Bool {
        currentGame != nil
    }
    
}

extension Set {
    mutating func start(serve: PlayerSide) -> Void {
        if (!self.isLive) {
            self.currentGame = Game(serve: serve)
        }
    }
    
    mutating func goToNextPoint(pointWinner: PlayerSide) -> Bool {
        if (!self.isLive) {
            return false
        }
        
        if (self.currentGame!.goToNextPoint(pointWinner: pointWinner)) {
            if (self.goToNextGame(gameWinner: pointWinner)) {
                return true
            }
        }
        
        return false
    }
    
    mutating func end() -> Void {
        if (!self.isLive) {
            return
        }
        let lastGame = self.currentGame!
        
        if (lastGame.isTieBreak) {
            self.hasTieBreak = true
            self.tieBreakPointsPlayerHome = lastGame.pointsPlayerHome.tieBreakValue!
            self.tieBreakPointsPlayerAway = lastGame.pointsPlayerAway.tieBreakValue!
        }
        self.currentGame = nil
    }
    
    private func getGames(player: PlayerSide) -> Int {
        switch player {
        case .playerHome:
            return self.gamesPlayerHome
        case .playerAway:
            return self.gamesPlayerAway
        }
    }

    private mutating func setGamesToPlayer(player: PlayerSide, games: Int) {
        switch player {
        case .playerHome:
            self.gamesPlayerHome = games
        case .playerAway:
            self.gamesPlayerAway = games
        }
    }
    
    private mutating func goToNextGame(gameWinner: PlayerSide) -> Bool {
        guard let game = self.currentGame else {
            return false
        }
        
        let gameLoser = PlayerSide.getOpponent(player: gameWinner)
        
        var gamesWinner = self.getGames(player: gameWinner)
        let gamesLoser = self.getGames(player: gameLoser)
        
        gamesWinner += 1
        self.setGamesToPlayer(player: gameWinner, games: gamesWinner)

        let newServe = PlayerSide.getOpponent(player: game.serve)
        
        // Next game is tie break
        if (gamesWinner == 6 && gamesLoser == 6) {
            self.currentGame = Game(pointsPlayerHome: .tieBreakPoint(0), pointsPlayerAway: .tieBreakPoint(0), serve: newServe)
            return false
        }
        
        // Win set
        if (gamesWinner == 7 || (gamesWinner == 6 && gamesLoser < 5)) {
            self.end()
            return true
        }
        
        self.currentGame = Game(serve: newServe)
        return false
    }
}
