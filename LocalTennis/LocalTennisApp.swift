//
//  LocalTennisApp.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 04-02-24.
//

import SwiftUI

@main
struct LocalTennisApp: App {
    @StateObject var localTennisManager = LocalTennisManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView() {
                Task {
                    do {
                        try await localTennisManager.saveData()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(localTennisManager)
            .task {
                do {
                    try await localTennisManager.loadData()
                } catch {
                    fatalError(error.localizedDescription)
                }
                
            }
        }
    }
}
