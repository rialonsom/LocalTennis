//
//  PlayersView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct PlayersView: View {
    @State private var isShowingNewPlayerSheet = false
    @EnvironmentObject var localTennisManager: LocalTennisManager
    
    var body: some View {
        let players = localTennisManager.players
        
        NavigationStack {
            List {
                ForEach(players) { player in
                    Text("\(player.name)")
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                localTennisManager.removePlayer(player: player)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
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
                NewPlayerSheetView(isPresented: $isShowingNewPlayerSheet)
            })
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        players: Player.examplePlayers
    )
    
    return PlayersView()
        .environmentObject(localTennisManager)
}
