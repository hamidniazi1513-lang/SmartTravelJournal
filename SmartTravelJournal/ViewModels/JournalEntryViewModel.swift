import Foundation
import SwiftData
import CoreLocation
import Observation

@MainActor
@Observable
final class JournalEntryViewModel {
    func saveEntry(title: String, body: String, mood: JournalMood,
                   location: CLLocation?, trip: Trip, context: ModelContext) {
        let entry = JournalEntry(title: title, body: body, mood: mood,
            latitude: location?.coordinate.latitude,
            longitude: location?.coordinate.longitude, trip: trip)
        context.insert(entry)
    }

    func deleteEntry(_ entry: JournalEntry, context: ModelContext) {
        context.delete(entry)
    }
}
