//
//  Player.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 18-01-24.
//

import Foundation

struct Player: Identifiable, Hashable, Codable {
    let id: UUID
    let name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}

extension Player {
    static let examplePlayers = [
        Player(name: "Rodrigo"),
        Player(name: "Juan"),
        Player(name: "Pedro"),
        Player(name: "Diego"),
    ]
}
