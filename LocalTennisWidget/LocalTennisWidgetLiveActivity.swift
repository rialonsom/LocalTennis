//
//  LocalTennisWidgetLiveActivity.swift
//  LocalTennisWidget
//
//  Created by Rodrigo Alonso on 25-05-24.
//

import ActivityKit
import WidgetKit
import SwiftUI



struct LocalTennisWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: LocalTennisWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                MatchScoreView(match: context.state.match)
                // TODO: Actions from live activity with intents
//                HStack {
//                    Button(action: {}) {
//                        Label("Home", systemImage: "plus")
//                    }
//                    Button(action: {}) {
//                        Label("Away", systemImage: "plus")
//                    }
//                }
            }
            .padding()

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Match")
                        .font(.title2)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Image(systemName: "tennisball.fill")
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .topLeading)
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(.red)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    MatchScoreView(match: context.state.match)
                        .padding(.top, 0.5)
                    // TODO: Actions from live activity with intents
//                    HStack {
//                        Button(action: {}) {
//                            Label("Home", systemImage: "plus")
//                        }
//                        Button(action: {}) {
//                            Label("Away", systemImage: "plus")
//                        }
//                    }
                }
            } compactLeading: {
                Image(systemName: "tennisball.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.red)
            } compactTrailing: {
                Text("Match")
            } minimal: {
                Image(systemName: "tennisball.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.red)
            }
            .keylineTint(Color.red)
        }
    }
}

extension LocalTennisWidgetAttributes {
    fileprivate static var preview: LocalTennisWidgetAttributes {
        LocalTennisWidgetAttributes()
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

#Preview("DI Expanded", as: .dynamicIsland(.expanded), using: LocalTennisWidgetAttributes.preview) {
   LocalTennisWidgetLiveActivity()
} contentStates: {
    LocalTennisWidgetAttributes.ContentState.exampleMatch
    LocalTennisWidgetAttributes.ContentState.exampleMatchTieBreak
}

#Preview("DI Compact", as: .dynamicIsland(.compact), using: LocalTennisWidgetAttributes.preview) {
   LocalTennisWidgetLiveActivity()
} contentStates: {
    LocalTennisWidgetAttributes.ContentState.exampleMatch
    LocalTennisWidgetAttributes.ContentState.exampleMatchTieBreak
}

#Preview("DI Minimal", as: .dynamicIsland(.minimal), using: LocalTennisWidgetAttributes.preview) {
   LocalTennisWidgetLiveActivity()
} contentStates: {
    LocalTennisWidgetAttributes.ContentState.exampleMatch
    LocalTennisWidgetAttributes.ContentState.exampleMatchTieBreak
}
