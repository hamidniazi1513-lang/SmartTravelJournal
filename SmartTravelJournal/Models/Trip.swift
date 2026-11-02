import Foundation
import SwiftData

@Model
final class Trip {
    var id: UUID
    var title: String
    var startDate: Date
    var endDate: Date
    var coverImageName: String
    var aiSummary: String
    var destination: String
    var notes: String
    var latitude: Double
    var longitude: Double
    var createdAt: Date

    @Relationship(deleteRule: .cascade, inverse: \JournalEntry.trip)
    var entries: [JournalEntry] = []

    init(title: String, destination: String, startDate: Date, endDate: Date,
         coverImageName: String = "airplane", aiSummary: String = "",
         notes: String = "", latitude: Double = 51.5072, longitude: Double = -0.1276) {
        self.id = UUID()
        self.title = title
        self.destination = destination
        self.startDate = startDate
        self.endDate = endDate
        self.coverImageName = coverImageName
        self.aiSummary = aiSummary
        self.notes = notes
        self.latitude = latitude
        self.longitude = longitude
        self.createdAt = Date()
    }
}
