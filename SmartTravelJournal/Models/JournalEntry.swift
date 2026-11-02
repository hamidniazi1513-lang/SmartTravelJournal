import Foundation
import SwiftData

enum JournalMood: String, CaseIterable, Codable, Identifiable {
    case happy = "Happy"
    case excited = "Excited"
    case relaxed = "Relaxed"
    case tired = "Tired"
    case grateful = "Grateful"
    case surprised = "Surprised"
    var id: String { rawValue }
    var emoji: String {
        switch self {
        case .happy: "😊"
        case .excited: "🤩"
        case .relaxed: "😌"
        case .tired: "😴"
        case .grateful: "🥰"
        case .surprised: "😮"
        }
    }
}

@Model
final class JournalEntry {
    var id: UUID
    var title: String
    var body: String
    var moodRawValue: String
    var latitude: Double?
    var longitude: Double?
    var timestamp: Date
    var imageName: String
    var smartTagsCSV: String
    var trip: Trip?

    var mood: JournalMood {
        get { JournalMood(rawValue: moodRawValue) ?? .happy }
        set { moodRawValue = newValue.rawValue }
    }

    var smartTags: [String] {
        get { smartTagsCSV.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty } }
        set { smartTagsCSV = newValue.joined(separator: ", ") }
    }

    init(title: String, body: String, mood: JournalMood = .happy,
         latitude: Double? = nil, longitude: Double? = nil,
         timestamp: Date = .now, imageName: String = "",
         smartTags: [String] = [], trip: Trip? = nil) {
        self.id = UUID()
        self.title = title
        self.body = body
        self.moodRawValue = mood.rawValue
        self.latitude = latitude
        self.longitude = longitude
        self.timestamp = timestamp
        self.imageName = imageName
        self.smartTagsCSV = smartTags.joined(separator: ", ")
        self.trip = trip
    }
}
