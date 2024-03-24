//
//  MainTabView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct MainTabView: View {
    @State private var players = Player.examplePlayers
    @State private var selectedTab = 0
    @State private var isShowingNewMatchSheet: Bool = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HistoryView(players: $players)
                .tabItem {
                    Label("History", systemImage: "figure.tennis")
                }
                .tag(0)
            Spacer()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                        .foregroundStyle(.green)
                }
                .tag(1)
            PlayersView(players: $players)
                .tabItem {
                    Label("Players", systemImage: "person.3.sequence")
                }
                .tag(2)
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if (newValue == 1) {
                selectedTab = oldValue
                isShowingNewMatchSheet = true
            } else {
                selectedTab = newValue
            }
        }
        .sheet(isPresented: $isShowingNewMatchSheet, content: {
            NewMatchView(players: $players, isPresented: $isShowingNewMatchSheet)
        })
        
    }
}

#Preview {
    MainTabView()
}
