//
//  PlayersView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct PlayersView: View {
    @Binding var players: [Player]
    @State private var isShowingNewPlayerSheet = false
    
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
                NewPlayerSheetView(isPresented: $isShowingNewPlayerSheet, players: $players)
            })
        }
    }
}

#Preview {
    PlayersView(players: .constant(Player.examplePlayers))
}
