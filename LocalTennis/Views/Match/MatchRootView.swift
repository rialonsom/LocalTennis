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
            if (localTennisManager.isMatchActive) {
                MatchView(match: localTennisManager.activeMatch!)
            } else if (!hasCreatedMatch) {
                NewMatchView()
            } else {
                EmptyView()
            }
        }
        .onChange(of: localTennisManager.isMatchActive) { oldValue, newValue in
            if (!oldValue && newValue) {
                hasCreatedMatch = true
            }
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        activeMatch: Match.exampleMatch
    )
    
    return MatchRootView()
        .environmentObject(localTennisManager)
}
