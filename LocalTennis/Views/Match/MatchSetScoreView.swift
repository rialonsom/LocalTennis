//
//  MatchGameScoreView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 17-05-24.
//

import SwiftUI

struct MatchSetScoreView: View {
    let games: Int
    let tiebreakPoints: Int?
    
    var body: some View {
        if (tiebreakPoints != nil) {
            Text("\(games)")
                .bold()
            +
            Text(" ")
                .font(.system(size: 4.0))
            +
            Text("\(tiebreakPoints!)")
                .baselineOffset(10.0)
                .font(.system(size: 12.0))
        } else {
            Text("\(games)")
                .bold()
        }
    }
}

#Preview {
    MatchSetScoreView(games: 7, tiebreakPoints: 5)
}

#Preview {
    MatchSetScoreView(games: 4, tiebreakPoints: nil)
}
