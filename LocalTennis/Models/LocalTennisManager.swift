//
//  LocalTennisManager.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 24-03-24.
//

import Foundation

class LocalTennisManager: ObservableObject {
    @Published var matches: [Match] = []
    @Published var players: [Player] = []
    @Published var currentOngoingMatch: Match? = nil
    
    var isMatchOngoing: Bool {
        currentOngoingMatch != nil
    }
    
    func setupOngoingMatch(playerHome: Player, playerAway: Player, mode: Match.Mode) -> Void {
        self.currentOngoingMatch = Match(playerHome: playerHome, playerAway: playerAway, mode: mode, currentSet: nil)
    }
    
    func saveAndRemoveOngoingMatch() -> Void {
        if (self.currentOngoingMatch != nil) {
            self.matches.insert(self.currentOngoingMatch!, at: 0)
        }
        self.currentOngoingMatch = nil
    }
    
    func loadData() async throws -> Void {
        let retrievedMatches = try await LocalTennisStore.loadMatches()
        let retrievedPlayers = try await LocalTennisStore.loadPlayers()
        await MainActor.run {
            matches = retrievedMatches
            players = retrievedPlayers
        }
    }
    
    func saveData() async throws -> Void {
        try await LocalTennisStore.saveMatches(matches: self.matches)
        try await LocalTennisStore.savePlayers(players: self.players)
    }
}

