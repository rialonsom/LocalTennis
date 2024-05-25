//
//  Game.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import Foundation

struct Game: Codable, Hashable {
    private(set) var pointsPlayerHome: Point
    private(set) var pointsPlayerAway: Point
    
    let serve: PlayerSide
    private(set) var currentServe: PlayerSide
    
    var isTieBreak: Bool {
        return pointsPlayerHome != .love
        && pointsPlayerHome != .fifteen
        && pointsPlayerHome != .thirty
        && pointsPlayerHome != .forty
        && pointsPlayerHome != .advantage
    }
    
    init(pointsPlayerHome: Point = .love, pointsPlayerAway: Point = .love, serve: PlayerSide, currentServe: PlayerSide? = nil) {
        self.pointsPlayerHome = pointsPlayerHome
        self.pointsPlayerAway = pointsPlayerAway
        self.serve = serve
        self.currentServe = currentServe ?? serve
    }
}

extension Game {
    enum Point: Comparable, Codable, Hashable {
        case love
        case fifteen
        case thirty
        case forty
        case advantage
        case tieBreakPoint(Int)
        
        var tieBreakValue: Int? {
            switch self {
            case .tieBreakPoint(let point):
                return point
            default:
                return nil
            }
        }
        
        var description: String {
            switch self {
            case .love:
                return "0"
            case .fifteen:
                return "15"
            case .thirty:
                return "30"
            case .forty:
                return "40"
            case .advantage:
                return "Ad"
            case .tieBreakPoint(let point):
                return "\(point)"
            }
        }
    }
}

extension Game {
    mutating func goToNextPoint(pointWinner: PlayerSide) -> Bool {
        let pointLoser = PlayerSide.getOpponent(player: pointWinner)
        
        let pointsWinner = self.getPoints(player: pointWinner)
        let pointsLoser = self.getPoints(player: pointLoser)
        
        // Win game
        if (!self.isTieBreak && pointsWinner >= .forty && pointsWinner > pointsLoser) {
            return true
        }
        
        // Advantage handling
        if (!self.isTieBreak && pointsWinner == .forty && pointsLoser == .advantage) {
            self.setPointsToPlayer(player: pointLoser, points: .forty)
            return false
        }
        
        // Add point
        switch pointsWinner {
        case .love:
            self.setPointsToPlayer(player: pointWinner, points: .fifteen)
        case .fifteen:
            self.setPointsToPlayer(player: pointWinner, points: .thirty)
        case .thirty:
            self.setPointsToPlayer(player: pointWinner, points: .forty)
        case .forty:
            self.setPointsToPlayer(player: pointWinner, points: .advantage)
        case .tieBreakPoint(let point):
            self.setPointsToPlayer(player: pointWinner, points: .tieBreakPoint(point + 1))
        default:
            ()
        }
        
        // Tie break handling
        if (self.isTieBreak) {
            let tieBreakPointsWinner = pointsWinner.tieBreakValue! + 1
            let tieBreakPointsLoser = pointsLoser.tieBreakValue!
            
            // Win game in tiebreak
            if (tieBreakPointsWinner >= 7 && tieBreakPointsWinner - tieBreakPointsLoser >= 2) {
                return true
            }
            
            // Serve handling
            if ((tieBreakPointsWinner + tieBreakPointsLoser) % 2 == 1) {
                let currentServe = self.currentServe
                let newServe = PlayerSide.getOpponent(player: currentServe)
                self.setCurrentServe(player: newServe)
            }
        }

        return false
    }
    
    private func getPoints(player: PlayerSide) -> Point {
        switch player {
        case .playerHome:
            return self.pointsPlayerHome
        case .playerAway:
            return self.pointsPlayerAway
        }
    }

    private mutating func setPointsToPlayer(player: PlayerSide, points: Point) -> Void {
        switch player {
        case .playerHome:
            self.pointsPlayerHome = points
        case .playerAway:
            self.pointsPlayerAway = points
        }
    }
    
    private mutating func setCurrentServe(player: PlayerSide) -> Void {
        self.currentServe = player
    }
}


