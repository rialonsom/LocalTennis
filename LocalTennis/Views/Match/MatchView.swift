//
//  MatchView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import SwiftUI

struct MatchView: View {
    @ObservedObject var match: Match
    @EnvironmentObject var localTennisManager: LocalTennisManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            MatchScoreView(match: match)
            Spacer()
            MatchActionsView(match: match)
            Spacer()
        }
        .padding()
        .navigationTitle("Ongoing match")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    withAnimation {
                        localTennisManager.removeActiveMatch()
                        dismiss()
                    }
                }, label: {
                    Text("Leave")
                })
            }
        }
    }
}

#Preview {
    NavigationStack {
        MatchView(match: Match.exampleMatchTieBreak)
            .environmentObject(LocalTennisManager())
    }
}
