//
//  HistoryView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct HistoryView: View {
    @Binding var players: [Player]
    
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
        }
    }
}

#Preview {
    HistoryView(players: .constant(Player.examplePlayers))
}
