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
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Spacer()
                
                MatchScoreView(match: match)
                
                Spacer()
                
                MatchActionsView(match: match)
                
                Spacer()
                
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        localTennisManager.removeOngoingMatch()
                    }, label: {
                        Text("Done")
                    })
                    .disabled(!match.isFinished)
                }
        }
        }
    }
}

#Preview {
    MatchView(match: Match.exampleMatchTieBreak)
        .environmentObject(LocalTennisManager())
}
