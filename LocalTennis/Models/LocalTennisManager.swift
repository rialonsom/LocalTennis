//
//  LocalTennisManager.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 24-03-24.
//

import Foundation

class LocalTennisManager: ObservableObject {
    @Published var currentOngoingMatch: Match? = nil
    
    var isMatchOngoing: Bool {
        currentOngoingMatch != nil
    }
    
    func setupOngoingMatch(playerHome: Player, playerAway: Player, mode: Match.Mode) -> Void {
        self.currentOngoingMatch = Match(playerHome: playerHome, playerAway: playerAway, mode: mode, currentSet: nil)
    }
    
    func removeOngoingMatch() -> Void {
        self.currentOngoingMatch = nil
    }
}
