//
//  Match.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 18-01-24.
//

import Foundation

class Match: ObservableObject {
    let playerHome: Player
    let playerAway: Player
    let mode: Mode
    
    enum Mode: Int {
        case bestOfThree = 3
        case bestOfFive = 5
    }
    
    @Published private(set) var sets: [Set]
    @Published private(set) var currentSet: Set?
    
    var isLive: Bool {
        currentSet != nil
    }
    
    var isFinished: Bool {
        !self.isLive && self.sets.count > 0
    }
    
    @Published var winner: PlayerSide?
    
    init(playerHome: Player, playerAway: Player, mode: Mode, sets: [Set] = [], currentSet: Set? = nil) {
        self.playerHome = playerHome
        self.playerAway = playerAway
        self.mode = mode
        self.sets = sets
        self.currentSet = currentSet
        self.winner = nil
    }
    
    init(playerHome: Player, playerAway: Player, mode: Mode, sets: [Set] = [], winner: PlayerSide? = nil) {
        self.playerHome = playerHome
        self.playerAway = playerAway
        self.mode = mode
        self.sets = sets
        self.currentSet = nil
        self.winner = winner
    }
}

extension Match {
    func start() -> Void {
        if (!self.isLive && self.sets.count == 0 && self.winner == nil) {
            let newSetId = self.sets.count + 1
            self.currentSet = Set(id: newSetId)
            self.currentSet!.start(serve: .playerHome)
        }
    }
    
    private func goToNextSet(setWinner: PlayerSide, newServe: PlayerSide) -> Void {
        if (!self.isLive) {
            return
        }
        let set = self.currentSet!
    
        self.sets.append(set)
        
        if (self.sets.count == self.mode.rawValue) {
            return self.end(matchWinner: setWinner)
        }
        
        let newSetId = set.id + 1
        self.currentSet = Set(id: newSetId)
        self.currentSet!.start(serve: newServe)
    }
    
    func goToNextPoint(pointWinner: PlayerSide) -> Void {
        if (!self.isLive) {
            return
        }
        
        guard let serve = self.currentSet!.currentGame?.currentServe else {
            return
        }
        
        if (self.currentSet!.goToNextPoint(pointWinner: pointWinner)) {
            let newServe = PlayerSide.getOpponent(player: serve)
            self.goToNextSet(setWinner: pointWinner, newServe: newServe)
        }
    }
    
    func end(matchWinner: PlayerSide) -> Void {
        if (!self.isLive) {
            return
        }
        
        // Early ending
        if (self.currentSet!.isLive) {
            self.currentSet!.end()
            self.sets.append(self.currentSet!)
        }

        self.currentSet = nil
        self.winner = matchWinner
    }
}

extension Match {
    static let exampleMatchNew = Match(
        playerHome: Player(id: "1", name: "Carlos Alcaraz"),
        playerAway: Player(id: "2", name: "Novak Djokovic"),
        mode: .bestOfThree,
        sets: [],
        currentSet: nil
    )
    
    static let exampleMatch = Match(
        playerHome: Player(id: "1", name: "Carlos Alcaraz"),
        playerAway: Player(id: "2", name: "Novak Djokovic"),
        mode: .bestOfThree,
        sets: [
            Set(id: 1, gamesPlayerHome: 6, gamesPlayerAway: 4),
            Set(id: 2, gamesPlayerHome: 6, gamesPlayerAway: 3)
        ],
        currentSet: Set(
            id: 3,
            gamesPlayerHome: 4,
            gamesPlayerAway: 5,
            currentGame: Game(pointsPlayerHome: .forty, pointsPlayerAway: .forty, serve: .playerAway)
        )
    )
    
    static let exampleMatchTieBreak = Match(
        playerHome: Player(id: "1", name: "Carlos Alcaraz"),
        playerAway: Player(id: "2", name: "Novak Djokovic"),
        mode: .bestOfFive,
        sets: [
            Set(id: 1, gamesPlayerHome: 6, gamesPlayerAway: 4),
            Set(id: 2, gamesPlayerHome: 6, gamesPlayerAway: 4),
            Set(id: 3, gamesPlayerHome: 5, gamesPlayerAway: 7),
            Set(id: 4, gamesPlayerHome: 6, gamesPlayerAway: 6)
        ],
        currentSet: Set(
            id: 5,
            gamesPlayerHome: 6,
            gamesPlayerAway: 6,
            currentGame: Game(pointsPlayerHome: .tieBreakPoint(5), pointsPlayerAway: .tieBreakPoint(3), serve: .playerAway)
        )
    )
}
