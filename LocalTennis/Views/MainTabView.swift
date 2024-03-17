//
//  MainTabView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct MainTabView: View {
    @State private var players = Player.examplePlayers
    
    var body: some View {
        TabView {
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "figure.tennis")
                }
            PlayersView(players: $players)
                .tabItem {
                    Label("Players", systemImage: "person.3.sequence")
                }
        }
    }
}

#Preview {
    MainTabView()
}
