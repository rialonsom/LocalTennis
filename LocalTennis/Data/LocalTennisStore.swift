//
//  LocalTennisStore.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 04-05-24.
//

import Foundation


class LocalTennisStore {
    enum LocalTennisStoreType: String {
        case matches = "localtennis.matches"
        case players = "localtennis.players"
    }
    
    private static func fileURL(type: LocalTennisStoreType) throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent(type.rawValue)
    }
    
    private static func load<T: Codable>(type: LocalTennisStoreType) async throws -> [T] {
        let task = Task<[T], Error> {
            let fileURL = try Self.fileURL(type: type)
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let entities = try JSONDecoder().decode([T].self, from: data)
            return entities
        }
        let entities = try await task.value
        return entities
    }
    
    
    private static func save<T: Codable>(entities: [T], type: LocalTennisStoreType) async throws -> Void {
        let task = Task {
            let data = try JSONEncoder().encode(entities)
            let outfile = try Self.fileURL(type: type)
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
    
    
    static func loadMatches() async throws -> [Match] {
        return try await load(type: .matches)
    }
    
    static func saveMatches(matches: [Match]) async throws -> Void {
        try await save(entities: matches, type: .matches)
    }
    
    static func loadPlayers() async throws -> [Player] {
        return try await load(type: .players)
    }
    
    static func savePlayers(players: [Player]) async throws -> Void {
        try await save(entities: players, type: .players)
    }
}
