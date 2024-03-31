//
//  MainTabView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 16-03-24.
//

import SwiftUI

struct MainTabView: View {
    @State private var players = Player.examplePlayers
    @State private var selectedTab = 0
    @State private var isShowingMatchSheet: Bool = false
    @StateObject private var localTennisManager = LocalTennisManager()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                Group {
                    HistoryView(players: $players)
                        .tabItem {
                            Label("History", systemImage: "figure.tennis")
                        }
                        .tag(0)
                    Spacer()
                        .tag(1)
                    PlayersView(players: $players)
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
                MatchSheetView(players: $players, isPresented: $isShowingMatchSheet)
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
        .environmentObject(localTennisManager)
    }
}


#Preview {
    MainTabView()
}
