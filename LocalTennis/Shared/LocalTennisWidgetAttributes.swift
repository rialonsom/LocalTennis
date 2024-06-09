//
//  LocalTennisWidgetAttributes.swift
//  LocalTennis
//
//  Created by Rodrigo Alonso on 25-05-24.
//

import Foundation
import ActivityKit

struct LocalTennisWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var match: Match
    }

    // Fixed non-changing properties about your activity go here!
}
