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
                        localTennisManager.addPlayer(player: Player(name: name))
                        isPresented.toggle()
                    }, label: {
                        Text("Create")
                    })
                }
            }
        }
    }
}

#Preview {
    NewPlayerSheetView(isPresented: .constant(true))
        .environmentObject(LocalTennisManager())
}
