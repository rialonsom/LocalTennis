//
//  MatchStackView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 31-03-24.
//

import SwiftUI

struct MatchRootView: View {
    @EnvironmentObject var localTennisManager: LocalTennisManager
    @State private var hasCreatedMatch: Bool = false
    
    var body: some View {
        NavigationStack {
            if (localTennisManager.isMatchOngoing) {
                MatchView(match: localTennisManager.currentOngoingMatch!)
            } else if (!hasCreatedMatch) {
                NewMatchView()
            } else {
                EmptyView()
            }
        }
        .onChange(of: localTennisManager.isMatchOngoing) { oldValue, newValue in
            if (!oldValue && newValue) {
                hasCreatedMatch = true
            }
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        currentOngoingMatch: Match.exampleMatch
    )
    
    return MatchRootView()
        .environmentObject(localTennisManager)
}
