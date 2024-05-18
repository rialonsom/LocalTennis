//
//  Match.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 18-01-24.
//

import Foundation

class Match: ObservableObject, Identifiable, Codable, Equatable {
    let id: UUID = UUID()
    let playerHome: String
    let playerAway: String
    let mode: Mode
    
    enum Mode: Int, Codable {
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
        self.playerHome = playerHome.name
        self.playerAway = playerAway.name
        self.mode = mode
        self.sets = sets
        self.currentSet = currentSet
        self.winner = nil
    }
    
    init(playerHome: Player, playerAway: Player, mode: Mode, sets: [Set] = [], winner: PlayerSide? = nil) {
        self.playerHome = playerHome.name
        self.playerAway = playerAway.name
        self.mode = mode
        self.sets = sets
        self.currentSet = nil
        self.winner = winner
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.playerHome = try container.decode(String.self, forKey: .playerHome)
        self.playerAway = try container.decode(String.self, forKey: .playerAway)
        self.mode = try container.decode(Mode.self, forKey: .mode)
        self.sets = try container.decode([Set].self, forKey: .sets)
        self.currentSet = try container.decode(Set?.self, forKey: .currentSet)
        self.winner = try container.decode(PlayerSide?.self, forKey: .winner)
    }
}

extension Match {
    enum CodingKeys: CodingKey {
        case playerHome
        case playerAway
        case mode
        case sets
        case currentSet
        case winner
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(playerHome, forKey: .playerHome)
        try container.encode(playerAway, forKey: .playerAway)
        try container.encode(mode, forKey: .mode)
        try container.encode(sets, forKey: .sets)
        try container.encode(currentSet, forKey: .currentSet)
        try container.encode(winner, forKey: .winner)
    }
}

extension Match {
    static func == (lhs: Match, rhs: Match) -> Bool {
        lhs.id == rhs.id
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
        playerHome: Player(name: "Rodrigo"),
        playerAway: Player(name: "Pedro"),
        mode: .bestOfThree,
        sets: [],
        currentSet: nil
    )
    
    static let exampleMatch = Match(
        playerHome: Player(name: "Juan"),
        playerAway: Player(name: "Rodrigo"),
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
        playerHome: Player(name: "Pedro"),
        playerAway: Player(name: "Juan"),
        mode: .bestOfFive,
        sets: [
            Set(id: 1, gamesPlayerHome: 6, gamesPlayerAway: 4),
            Set(id: 2, gamesPlayerHome: 6, gamesPlayerAway: 4),
            Set(id: 3, gamesPlayerHome: 5, gamesPlayerAway: 7),
            Set(id: 4,
                gamesPlayerHome: 6,
                gamesPlayerAway: 7,
                hasTieBreak: true,
                tieBreakPointsPlayerHome: 4,
                tieBreakPointsPlayerAway: 7
               ),
        ],
        currentSet: Set(
            id: 5,
            gamesPlayerHome: 6,
            gamesPlayerAway: 6,
            currentGame: Game(pointsPlayerHome: .forty, pointsPlayerAway: .forty, serve: .playerAway)
        )
    )
    
    static let exampleHistoryMatches = [
        Match(
            playerHome: Player(name: "Rodrigo"),
            playerAway: Player(name: "Juan"),
            mode: .bestOfThree,
            sets: [
                Set(id: 1, gamesPlayerHome: 6, gamesPlayerAway: 4),
                Set(id: 2, gamesPlayerHome: 7, gamesPlayerAway: 5)
            ],
            winner: .playerHome
        ),
        Match(
            playerHome: Player(name: "Pedro"),
            playerAway: Player(name: "Rodrigo"),
            mode: .bestOfThree,
            sets: [
                Set(id: 1, gamesPlayerHome: 4, gamesPlayerAway: 6),
                Set(id: 2, gamesPlayerHome: 5, gamesPlayerAway: 7)
            ],
            winner: .playerAway
        ),
        Match(
            playerHome: Player(name: "Pedro"),
            playerAway: Player(name: "Juan"),
            mode: .bestOfFive,
            sets: [
                Set(id: 1, gamesPlayerHome: 6, gamesPlayerAway: 4),
                Set(id: 2, gamesPlayerHome: 7, gamesPlayerAway: 5),
                Set(id: 3, gamesPlayerHome: 3, gamesPlayerAway: 6),
                Set(id: 4, gamesPlayerHome: 6, gamesPlayerAway: 0)
            ],
            winner: .playerHome
        )
    ]
}
