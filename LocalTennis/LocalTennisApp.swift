//
//  LocalTennisApp.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 04-02-24.
//

import SwiftUI

@main
struct LocalTennisApp: App {
    @StateObject var localTennisManager = LocalTennisManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView() {
                Task {
                    do {
                        let matches = localTennisManager.matches
                        let players = localTennisManager.players
                        
                        try await LocalTennisStore.saveMatches(matches: matches)
                        try await LocalTennisStore.savePlayers(players: players)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(localTennisManager)
            .task {
                do {
                    let retrievedMatches = try await LocalTennisStore.loadMatches()
                    let retrievedPlayers = try await LocalTennisStore.loadPlayers()
                    await localTennisManager.setData(
                        nextMatches: retrievedMatches,
                        nextPlayers: retrievedPlayers
                    )
                } catch {
                    fatalError(error.localizedDescription)
                }
                
            }
        }
    }
}
