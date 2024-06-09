//
//  NewMatchView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 17-03-24.
//

import SwiftUI

struct NewMatchView: View {
    @Binding var isPresented: Bool
    @EnvironmentObject var localTennisManager: LocalTennisManager
    @State private var selectedPlayerHome: Player = Player(name: "")
    @State private var selectedPlayerAway: Player = Player(name: "")
    @State private var selectedMode: Match.Mode = .bestOfThree
    
    @State private var focusedField: FocusedField? = nil
    
    private enum FocusedField {
        case playerHome
        case playerAway
    }
    
    var body: some View {
        let players = localTennisManager.players
        
        List {
            // Player home
            Button(action: {
                withAnimation {
                    focusedField = focusedField != .playerHome ? .playerHome : nil
                }
            }, label: {
                HStack {
                    Text("Player home")
                    Spacer()
                    Text("\(selectedPlayerHome.name)")
                        .tint(focusedField == .playerHome ? .red : .primary)
                        .padding(.all, 5)
                        .background(.fill, in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                }
                .contentShape(Rectangle())
            })
            
            if (focusedField == .playerHome) {
                Picker("Player home", selection: $selectedPlayerHome) {
                    ForEach(players) { player in
                        if (player != selectedPlayerAway) {
                            Text(player.name)
                                .tag(player)
                        }
                    }
                }
                .pickerStyle(.wheel)
            }
            
            // Player away
            Button(action: {
                withAnimation {
                    focusedField = focusedField != .playerAway ? .playerAway : nil
                }
            }, label: {
                HStack {
                    Text("Player away")
                    Spacer()
                    Text("\(selectedPlayerAway.name)")
                        .tint(focusedField == .playerAway ? .red : .primary)
                        .padding(.all, 5)
                        .background(.fill, in: RoundedRectangle(cornerSize: CGSize(width: 5, height: 5)))
                }
                .contentShape(Rectangle())
            })
            if (focusedField == .playerAway) {
                Picker("Player away", selection: $selectedPlayerAway) {
                    ForEach(players) { player in
                        if (player != selectedPlayerHome) {
                            Text(player.name)
                                .tag(player)
                        }
                    }
                }
                .pickerStyle(.wheel)
            }
            
            // Mode
            Picker("Mode", selection: $selectedMode) {
                Text("Best of 3").tag(Match.Mode.bestOfThree)
                Text("Best of 5").tag(Match.Mode.bestOfFive)
            }
        }
        .navigationTitle("New match")
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
                    withAnimation {
                        localTennisManager.setupOngoingMatch(
                            playerHome: selectedPlayerHome,
                            playerAway: selectedPlayerAway,
                            mode: selectedMode
                        )
                    }
                }, label: {
                    Text("Create")
                })
            }
        }
        .onAppear {
            selectedPlayerHome = players[0]
            selectedPlayerAway = players[1]
        }
    }
}

#Preview {
    let localTennisManager = LocalTennisManager(
        players: Player.examplePlayers
    )
    
    return NavigationStack {
        NewMatchView(
            isPresented: .constant(true)
        )
    }
    .environmentObject(localTennisManager)
}
