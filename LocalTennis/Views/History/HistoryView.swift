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
        .overlay {
            if (localTennisManager.matches.isEmpty) {
                VStack {
                    Image(systemName: "tennis.racket")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 90)
                        .foregroundStyle(.accent)
                    Text("No matches")
                        .font(.title)
                    Text("You can start playing by tapping on the tennis ball icon below")
                }
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
            }
        }
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

#Preview {
    let localTennisManager = LocalTennisManager(
        matches: []
    )
    
    return NavigationStack {
        HistoryView()
            .environmentObject(localTennisManager)
    }
}
