//
//  Utils.swift
//  TennisSync
//
//  Created by Rodrigo Alonso on 21-01-24.
//

import Foundation

enum PlayerSide {
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
