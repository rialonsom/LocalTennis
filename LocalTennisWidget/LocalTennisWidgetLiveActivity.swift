//
//  LocalTennisWidgetLiveActivity.swift
//  LocalTennisWidget
//
//  Created by Rodrigo Alonso on 25-05-24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct LocalTennisWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var match: Match
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct LocalTennisWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LocalTennisWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                MatchScoreView(match: context.state.match)
                    .padding()
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T")
            } minimal: {
                Text("M")
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension LocalTennisWidgetAttributes {
    fileprivate static var preview: LocalTennisWidgetAttributes {
        LocalTennisWidgetAttributes(name: "World")
    }
}

extension LocalTennisWidgetAttributes.ContentState {
    fileprivate static var exampleMatch: LocalTennisWidgetAttributes.ContentState {
        LocalTennisWidgetAttributes.ContentState(match: Match.exampleMatch)
     }
     
     fileprivate static var exampleMatchTieBreak: LocalTennisWidgetAttributes.ContentState {
         LocalTennisWidgetAttributes.ContentState(match: Match.exampleMatchTieBreak)
     }
}

#Preview("Notification", as: .content, using: LocalTennisWidgetAttributes.preview) {
   LocalTennisWidgetLiveActivity()
} contentStates: {
    LocalTennisWidgetAttributes.ContentState.exampleMatch
    LocalTennisWidgetAttributes.ContentState.exampleMatchTieBreak
}
