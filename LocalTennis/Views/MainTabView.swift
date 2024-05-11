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
    
    var body: some View {
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
            .tint(.black)
            
            Button(action: {
                isShowingMatchSheet = true
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .tint(.red)
                    .background(.white)
            })
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .padding(.bottom, 20)
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
