//
//  MatchView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import SwiftUI

struct MatchView: View {
    @EnvironmentObject var match: Match
    
    var body: some View {
        VStack {
            
            Spacer()
            
            MatchScoreView()
            
            Spacer()
            
            MatchActionsView()
            
            Spacer()

        }
    }
}

#Preview {
    return MatchView()
        .environmentObject(Match.exampleMatchTieBreak)
}
