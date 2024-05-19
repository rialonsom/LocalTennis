//
//  Utils.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 21-01-24.
//

import Foundation

enum PlayerSide: Codable, Identifiable {
    var id: Self {
        return self
    }
    
    case playerHome
    case playerAway
    
    static func getOpponent(player: PlayerSide) -> PlayerSide {
        switch player {
        case .playerHome:
            return .playerAway
        case .playerAway:
            return .playerHome
        }
    }
}
