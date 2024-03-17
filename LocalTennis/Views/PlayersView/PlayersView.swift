//
//  PlayersView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct PlayersView: View {
    @State private var isShowingNewPlayerSheet = false
    @State private var players = Player.examplePlayers
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(players) { player in
                    Text("\(player.name)")
                }
            }
            .navigationTitle("Players")
            .toolbar {
                Button(action: {
                    isShowingNewPlayerSheet.toggle()
                }, label: {
                    Label("New match", systemImage: "plus")
                })
            }
            .sheet(isPresented: $isShowingNewPlayerSheet, content: {
                NewPlayerView(isPresented: $isShowingNewPlayerSheet, players: $players)
            })
        }
    }
}

#Preview {
    PlayersView()
}
