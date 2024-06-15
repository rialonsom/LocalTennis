//
//  HistoryView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var localTennisManager: LocalTennisManager
    
    var body: some View {
        List {
            ForEach(localTennisManager.matches) { match in
                MatchScoreView(match: match)
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            localTennisManager.removeMatch(match: match)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        if (!match.isFinished) {
                            Button(role: .cancel) {
                                localTennisManager.setActiveMatch(match: match)
                            } label: {
                                Label("Resume", systemImage: "play")
                            }
                            .tint(.green)
                        }
                    }
            }
        }
        .listStyle(.plain)
        .navigationTitle("History")
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        matches: Match.exampleHistoryMatches
    )
    
    return NavigationStack {
        HistoryView()
            .environmentObject(localTennisManager)
    }
}
