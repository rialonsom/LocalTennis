//
//  DebugSheetView.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 14-06-24.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Text("Settings view")
            Button(action: {
                dismiss()
            }, label: {
                Text("Dismiss")
            })
        }
    }
}

#Preview {
    SettingsView()
}
