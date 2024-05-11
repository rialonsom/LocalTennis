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
        NavigationStack {
            List {
                ForEach(localTennisManager.matches) { match in
                    MatchScoreView(match: match)
                }
            }
            .listStyle(.plain)
            .navigationTitle("History")
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        matches: Match.exampleHistoryMatches
    )
    
    return HistoryView()
        .environmentObject(localTennisManager)
}
