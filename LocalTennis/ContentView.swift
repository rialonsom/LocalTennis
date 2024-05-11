//
//  ContentView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 04-02-24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        MainTabView()
            .onChange(of: scenePhase, { oldValue, newValue in
                if (newValue == .inactive) {
                    saveAction()
                }
            })
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        matches: Match.exampleHistoryMatches,
        players: Player.examplePlayers
    )
    
    return ContentView(saveAction: {})
        .environmentObject(localTennisManager)
}
