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
            NewPlayerSheetView()
        })
        .overlay {
            if (localTennisManager.players.isEmpty) {
                VStack {
                    Image(systemName: "tennis.racket")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.accent)
                        .padding(.horizontal, 90)
                    Text("No players")
                        .font(.title)
                    Text("You can add new players by tapping the + icon at the top right corner")
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
            }
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        players: Player.examplePlayers
    )
    
    return NavigationStack {
        PlayersView()
            .environmentObject(localTennisManager)
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        players: []
    )
    
    return NavigationStack {
        PlayersView()
            .environmentObject(localTennisManager)
    }
}
