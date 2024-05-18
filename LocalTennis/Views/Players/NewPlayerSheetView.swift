//
//  NewPlayerView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 17-03-24.
//

import SwiftUI

struct NewPlayerSheetView: View {
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @EnvironmentObject var localTennisManager: LocalTennisManager
    @State private var isShowingValidationAlert = false
    
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $name)
            }
            .navigationTitle("New player")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        isPresented.toggle()
                    }, label: {
                        Text("Cancel")
                            .tint(.red)
                    })
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if (validatePlayerName(name: name)) {
                            localTennisManager.addPlayer(player: Player(name: name))
                            isPresented.toggle()
                        } else {
                            isShowingValidationAlert = true
                        }
                    }, label: {
                        Text("Create")
                    })
                }
            }
        }
        .alert("Can't create player", isPresented: $isShowingValidationAlert) {
            Button(action: {}, label: {
                Text("Ok")
            })
        } message: {
            Text("Player name can't be empty or the same as another player.")
        }

    }
}

extension NewPlayerSheetView {
    private func validatePlayerName(name: String) -> Bool {
        if (name.isEmpty) {
            return false
        }
        
        return !localTennisManager.players.contains { player in
            player.name == name
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        players: Player.examplePlayers
    )
    
    return NewPlayerSheetView(isPresented: .constant(true))
        .environmentObject(localTennisManager)
}
