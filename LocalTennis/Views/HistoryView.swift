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
                Text("Match 1")
                Text("Match 2")
            }
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
