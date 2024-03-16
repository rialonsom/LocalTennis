//
//  MainTabView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "figure.tennis")
                }
            PlayersView()
                .tabItem {
                    Label("Players", systemImage: "person.3.sequence")
                }
        }
    }
}

#Preview {
    MainTabView()
}
