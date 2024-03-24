//
//  MatchView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 19-01-24.
//

import SwiftUI

struct MatchView: View {
    @ObservedObject var match: Match
    
    var body: some View {
        VStack {
            
            Spacer()
            
            MatchScoreView(match: match)
            
            Spacer()
            
            MatchActionsView(match: match)
            
            Spacer()

        }
    }
}

#Preview {
    MatchView(match: Match.exampleMatchTieBreak)
}
