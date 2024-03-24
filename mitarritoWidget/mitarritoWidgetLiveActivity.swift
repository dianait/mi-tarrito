//
//  mitarritoWidgetLiveActivity.swift
//  mitarritoWidget
//
//  Created by Diana Hernández on 24/3/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct mitarritoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct mitarritoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: mitarritoWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
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
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension mitarritoWidgetAttributes {
    fileprivate static var preview: mitarritoWidgetAttributes {
        mitarritoWidgetAttributes(name: "World")
    }
}

extension mitarritoWidgetAttributes.ContentState {
    fileprivate static var smiley: mitarritoWidgetAttributes.ContentState {
        mitarritoWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: mitarritoWidgetAttributes.ContentState {
         mitarritoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: mitarritoWidgetAttributes.preview) {
   mitarritoWidgetLiveActivity()
} contentStates: {
    mitarritoWidgetAttributes.ContentState.smiley
    mitarritoWidgetAttributes.ContentState.starEyes
}
