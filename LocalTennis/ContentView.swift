//
//  ContentView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 04-02-24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MatchView()
            .environmentObject(Match.exampleMatchNew)
    }
}

#Preview {
    ContentView()
}
