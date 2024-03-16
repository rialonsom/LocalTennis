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
            
            MatchViewScore()
            
            Spacer()
            
            MatchViewActions()
            
            Spacer()

        }
    }
}

#Preview {
    let match = Match.exampleMatchNew
    
    return MatchView()
        .environmentObject(match)
}
