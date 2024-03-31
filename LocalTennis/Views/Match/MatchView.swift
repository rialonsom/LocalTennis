//
//  MatchView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import SwiftUI

struct MatchView: View {
    @ObservedObject var match: Match
    @Binding var isPresented: Bool
    @EnvironmentObject var localTennisManager: LocalTennisManager
    
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
                        isPresented.toggle()
                        localTennisManager.removeOngoingMatch()
                    }
                }, label: {
                    Text("Done")
                })
                .disabled(!match.isFinished)
            }
        }
    }
}

#Preview {
    NavigationStack {
        MatchView(match: Match.exampleMatchTieBreak, isPresented: .constant(true))
            .environmentObject(LocalTennisManager())
    }
}
