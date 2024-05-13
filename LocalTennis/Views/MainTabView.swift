//
//  MainTabView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @State private var isShowingMatchSheet: Bool = false
    @State private var isShowingNewMatchAlert: Bool = false
    @EnvironmentObject var localTennisManager: LocalTennisManager
    private let newMatchAlertTitle = "You need to create at least two players before playing a match."
    
    var body: some View {
        let newMatchEnabled = localTennisManager.players.count >= 2
        
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Group {
                    HistoryView()
                        .tabItem {
                            Label("History", systemImage: "figure.tennis")
                        }
                        .tag(0)
                    Spacer()
                        .tag(1)
                    PlayersView()
                        .tabItem {
                            Label("Players", systemImage: "person.3.sequence")
                        }
                        .tag(2)
                }
                .toolbarBackground(.visible, for: .tabBar)
            }
            .onChange(of: selectedTab) { oldValue, newValue in
                selectedTab = newValue == 1 ? oldValue: newValue
            }
            .fullScreenCover(isPresented: $isShowingMatchSheet, content: {
                MatchSheetView(isPresented: $isShowingMatchSheet)
            })
            
            Button(action: {
                isShowingMatchSheet = true
            }, label: {
                Image(systemName: "tennisball.fill")
                    .resizable()
                    .tint(.red)
                    .background(.white)
            })
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(.bottom, 20)
            .disabled(!newMatchEnabled)
            .onTapGesture {
                if (!newMatchEnabled) {
                    isShowingNewMatchAlert = true
                }
            }
            .alert(newMatchAlertTitle, isPresented: $isShowingNewMatchAlert) {
                Button(action: {
                    isShowingNewMatchAlert = false
                }, label: {
                    Text("Ok")
                })
            }
        }
    }
}


#Preview {
    let localTennisManager = LocalTennisManager(
        matches: Match.exampleHistoryMatches,
        players: Player.examplePlayers
    )
    
    return MainTabView()
        .environmentObject(localTennisManager)
}

#Preview {
    let localTennisManager = LocalTennisManager(
        matches: Match.exampleHistoryMatches,
        players: []
    )
    
    return MainTabView()
        .environmentObject(localTennisManager)
}
