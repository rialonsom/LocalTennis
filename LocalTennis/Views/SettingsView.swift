//
//  DebugSheetView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 14-06-24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var localTennisManager: LocalTennisManager
    
    var body: some View {
        NavigationStack {
            List {
                Text("Common setting 1")
                Text("Common setting 2")
                
                #if DEBUG
                Section {
                    Button(action: {
                        Task {
                            await localTennisManager.setData(
                                nextMatches: Match.exampleHistoryMatches,
                                nextPlayers: Player.examplePlayers
                            )
                        }
                    }, label: {
                        Text("Load example data")
                            .tint(.blue)
                    })
                    
                    Button(action: {
                        Task {
                            await localTennisManager.setData(
                                nextMatches: [],
                                nextPlayers: []
                            )
                        }
                    }, label: {
                        Text("Clear all data")
                            .tint(.blue)
                    })
                } header: {
                    Label("Debug", systemImage: "ant")
                }
                #endif
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Done")
                    })
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LocalTennisManager())
}
