import Foundation
import SwiftData
import Observation

@MainActor
@Observable
final class TripsViewModel {
    var searchText = ""

    func filteredTrips(_ trips: [Trip]) -> [Trip] {
        guard !searchText.isEmpty else { return trips }
        return trips.filter {
            $0.title.localizedCaseInsensitiveContains(searchText) ||
            $0.destination.localizedCaseInsensitiveContains(searchText)
        }
    }

    func createTrip(title: String, destination: String, startDate: Date,
                    endDate: Date, context: ModelContext) {
        let trip = Trip(title: title, destination: destination,
                        startDate: startDate, endDate: endDate)
        context.insert(trip)
    }

    func deleteTrip(_ trip: Trip, context: ModelContext) {
        context.delete(trip)
    }
}
