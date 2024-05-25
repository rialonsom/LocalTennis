//
//  LocalTennisManager.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 24-03-24.
//

import Foundation
import ActivityKit

class LocalTennisManager: ObservableObject {
    @Published private(set) var matches: [Match] = []
    @Published private(set) var players: [Player] = []
    @Published private(set) var currentOngoingMatch: Match? = nil
    
    var isMatchOngoing: Bool {
        currentOngoingMatch != nil
    }
    
    init(matches: [Match] = [], players: [Player] = [], currentOngoingMatch: Match? = nil) {
        self.matches = matches
        self.players = players
        self.currentOngoingMatch = currentOngoingMatch
    }
}

extension LocalTennisManager {
    func setupOngoingMatch(playerHome: Player, playerAway: Player, mode: Match.Mode) -> Void {
        self.currentOngoingMatch = Match(playerHome: playerHome, playerAway: playerAway, mode: mode, currentSet: nil)
    }
    
    func saveAndRemoveOngoingMatch() -> Void {
        if (self.currentOngoingMatch != nil) {
            self.matches.insert(self.currentOngoingMatch!, at: 0)
        }
        self.currentOngoingMatch = nil
    }
    
    func removeMatch(match: Match) -> Void {
        guard let index = self.matches.firstIndex(of: match) else {
            return
        }
        self.matches.remove(at: index)
    }
    
    func addPlayer(player: Player) -> Void {
        self.players.insert(player, at: 0)
    }
    
    func removePlayer(player: Player) -> Void {
        guard let index = self.players.firstIndex(of: player) else {
            return
        }
        self.players.remove(at: index)
    }
}

extension LocalTennisManager {
    func setData(nextMatches: [Match], nextPlayers: [Player]) async -> Void {
        await MainActor.run {
            self.matches = nextMatches
            self.players = nextPlayers
        }
    }
}

extension LocalTennisManager {
    func startLiveActivity() throws -> Void {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            return
        }
        
        guard let ongoingMatch = self.currentOngoingMatch else {
            return
        }
        
        let activityAttributes = LocalTennisWidgetAttributes(name: "Match")
        let activityInitialState = LocalTennisWidgetAttributes.ContentState(
            match: ongoingMatch
        )
        let _ = try Activity.request(
            attributes: activityAttributes,
            content: .init(
                state: activityInitialState,
                staleDate: nil
            )
        )
    }
}
