//
//  MatchStackView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 31-03-24.
//

import SwiftUI

struct MatchSheetView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var localTennisManager: LocalTennisManager
    @State private var hasCreatedMatch: Bool = false
    
    var body: some View {
        NavigationStack {
            if (localTennisManager.isMatchOngoing) {
                MatchView(match: localTennisManager.currentOngoingMatch!, isPresented: $isPresented)
            } else if (!hasCreatedMatch) {
                NewMatchView(isPresented: $isPresented)
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
    
    return MatchSheetView(
        isPresented: .constant(true)
    )
    .environmentObject(localTennisManager)
}
