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
    @Published private(set) var activeMatch: Match? = nil
    
    private var activity: Activity<LocalTennisWidgetAttributes>? = nil
    @Published private(set) var isLiveActivityActive = false
    
    var isMatchActive: Bool {
        activeMatch != nil
    }
    
    init(matches: [Match] = [], players: [Player] = [], activeMatch: Match? = nil) {
        self.matches = matches
        self.players = players
        self.activeMatch = activeMatch
    }
}

extension LocalTennisManager {
    func setNewActiveMatch(playerHome: Player, playerAway: Player, mode: Match.Mode) -> Void {
        let activeMatch = Match(playerHome: playerHome, playerAway: playerAway, mode: mode, currentSet: nil)
        
        self.matches.insert(activeMatch, at: 0)
        self.activeMatch = activeMatch
    }
    
    func setActiveMatch(match: Match) -> Void {
        self.activeMatch = match
    }
    
    func removeActiveMatch() -> Void {
        self.activeMatch = nil
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
        
        guard let activeMatch = self.activeMatch else {
            return
        }
        
        let activityAttributes = LocalTennisWidgetAttributes()
        let activityInitialState = LocalTennisWidgetAttributes.ContentState(
            match: activeMatch
        )
        let newActivity = try Activity.request(
            attributes: activityAttributes,
            content: .init(
                state: activityInitialState,
                staleDate: nil
            )
        )
        
        Task {
            for await activityState in newActivity.activityStateUpdates {
                await MainActor.run {
                    self.isLiveActivityActive = activityState == .active
                }
            }
        }
        
        self.activity = newActivity
    }
    
    func updateLiveActivity() -> Void {
        guard let activity = self.activity else {
            return
        }
        
        guard let activeMatch = self.activeMatch else {
            return
        }
        
        let contentState = LocalTennisWidgetAttributes.ContentState(match: activeMatch)
        
        Task {
            await activity.update(ActivityContent<Activity<LocalTennisWidgetAttributes>.ContentState>(
                state: contentState, staleDate: nil
            ))
        }
    }
}
