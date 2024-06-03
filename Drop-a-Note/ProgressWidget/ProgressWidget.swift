//
//  ProgressWidget.swift
//  ProgressWidget
//
//  Created by Balint Dombovari on 2022. 11. 16..
//

import WidgetKit
import SwiftUI
import Intents
import CoreData

struct Provider: IntentTimelineProvider {
    

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), consumption: 0.0, goal: 0.0, language: 0, measure: 0, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), consumption: 0.0, goal: 0.0, language: 0, measure: 0, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        var entries: [SimpleEntry] = []
        //Datas from userdefaults
        let userDefaults: UserDefaults = UserDefaults(suiteName: "group.widgetdatasend")!
        let userDefaults2: UserDefaults = UserDefaults(suiteName: "group.settingsdata")!
        var doubleconsumption: Double = userDefaults.value(forKey: "self.day.consumption") as? Double ?? 0.0
        let Measure: Int = userDefaults2.value(forKey: "Measure") as? Int ?? 0
        var Goal: Double = 0.0
        switch Measure{
        case 0:
            Goal = userDefaults2.value(forKey: "PickerData") as? Double ?? 1.0
        case 1:
            Goal = userDefaults2.value(forKey: "PickerData") as? Double ?? 35.0
        case 2:
            Goal = userDefaults2.value(forKey: "PickerData") as? Double ?? 34.0
        default:
            Goal = userDefaults2.value(forKey: "PickerData") as? Double ?? 1.0
        }
        let Language: Int = userDefaults2.value(forKey: "Language") as? Int ?? 0
        for dayOffset in 0 ..< 7 {
            let entryDate = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date())!
            let startofDay = Calendar.current.startOfDay(for: entryDate)
            let entry = SimpleEntry(date: startofDay, consumption: doubleconsumption, goal: Goal  , language: Language, measure: Measure, configuration: configuration)
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let consumption: Double
    let goal: Double
    let language: Int
    let measure: Int
    let configuration: ConfigurationIntent
   
}
//Widgetview
struct ProgressWidgetEntryView : View {
    @Environment(\.widgetFamily) var widgetFamily
    var entry: Provider.Entry

    var body: some View {
        
            SmallSizeView(entry: entry)
        
        }
    }


struct ProgressWidget: Widget {
    let kind: String = "ProgressWidget"
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            ProgressWidgetEntryView(entry: entry)
        }
        .supportedFamilies([.systemSmall])
        .configurationDisplayName("ProgressWidget")
        .description("Drop-a-Note")
    }
    
}

struct ProgressWidget_Previews: PreviewProvider {
    static var previews: some View {
        ProgressWidgetEntryView(entry: SimpleEntry(date: Date(), consumption: 0.0, goal: 0.0, language: 0, measure: 0, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
