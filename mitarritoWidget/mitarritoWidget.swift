import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), count: 3)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), count: 2)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, count: 2)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let count: Int
}

struct mitarritoWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        ZStack(alignment: .top) {
            Image(.tarrrito)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(.top, 20)
                .frame(width: 300)

            Text("\(entry.count)")
                .font(.system(size: 70))
                .padding(.top, 65)
                .padding(.leading, 5)
                .bold()
                .foregroundColor(.brown)
        }
    }
}

struct mitarritoWidget: Widget {
    let kind: String = "mitarritoWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                mitarritoWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                mitarritoWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Mi tarrito")
        .description("Logros y demás cosas bonitas 😊")
    }
}

#Preview(as: .systemSmall) {
    mitarritoWidget()
} timeline: {
    SimpleEntry(date: .now, count: 14)
    SimpleEntry(date: .now, count: 34)
}
