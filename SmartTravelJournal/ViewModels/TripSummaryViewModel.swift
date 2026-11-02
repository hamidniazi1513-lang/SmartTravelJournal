import Foundation
import Observation

@MainActor
@Observable
final class TripSummaryViewModel {
    var summary: TripSummary?
    var isGenerating = false
    var errorMessage: String?
    private let service = AIService()

    func generate(for trip: Trip) async {
        isGenerating = true
        errorMessage = nil
        defer { isGenerating = false }
        do {
            summary = try await service.generateTripSummary(for: trip)
            if let summary {
                trip.aiSummary = "\(summary.summary)\n\nHighlight: \(summary.highlight)\n\nRecommendation: \(summary.recommendation)"
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func retry(for trip: Trip) async {
        await generate(for: trip)
    }
}
