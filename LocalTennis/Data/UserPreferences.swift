//
//  UserPreferences.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 20-06-24.
//

import Foundation
import SwiftUI

class UserPreferences: ObservableObject {
    private struct UserDefaultKeys {
        static let liveActivitiesEnabled = "liveActivitiesEnabled"
    }
    
    @AppStorage(UserDefaultKeys.liveActivitiesEnabled) var liveActivitiesEnabled = false
}
