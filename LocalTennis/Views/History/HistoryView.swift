//
//  HistoryView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct HistoryView: View {
    @Binding var players: [Player]
    @State private var isShowingNewMatchSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Match.exampleHistoryMatches) { match in
                    MatchScoreView()
                        .environmentObject(match)
                }
            }
            .listStyle(.plain)
            .navigationTitle("History")
            .toolbar {
                Button(action: {
                    isShowingNewMatchSheet.toggle()
                }, label: {
                    Label("New match", systemImage: "plus")
                })
            }
            .sheet(isPresented: $isShowingNewMatchSheet, content: {
                NewMatchView(players: $players, isPresented: $isShowingNewMatchSheet)
            })
        }
    }
}

#Preview {
    HistoryView(players: .constant(Player.examplePlayers))
}
