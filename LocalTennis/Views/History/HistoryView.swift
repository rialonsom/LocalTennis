//
//  HistoryView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(Match.exampleHistoryMatches) { match in
                    MatchScoreView()
                        .environmentObject(match)
                }
            }
            .listStyle(.plain)
            .navigationTitle("History")
            .toolbar {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Label("New match", systemImage: "plus")
                })
            }
        }
    }
}

#Preview {
    HistoryView()
}
