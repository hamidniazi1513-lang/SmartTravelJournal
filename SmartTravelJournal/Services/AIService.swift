import Foundation
import FoundationModels

struct AIService {
    func generateTripSummary(for trip: Trip) async throws -> TripSummary {
        guard SystemLanguageModel.default.availability == .available else {
            throw AIError.unavailable
        }
        do {
            let session = LanguageModelSession()
            let prompt = "Summarize this trip and give a highlight and recommendation. Trip: \(trip.title). Destination: \(trip.destination). Notes: \(trip.notes)"
            let result = try await session.respond(to: prompt, generating: TripSummary.self)
            return result.content
        } catch {
            throw AIError.generationFailed
        }
    }

    func generateSmartTags(for entry: JournalEntry) async throws -> SmartTags {
        guard SystemLanguageModel.default.availability == .available else {
            throw AIError.unavailable
        }
        do {
            let session = LanguageModelSession()
            let result = try await session.respond(
                to: "Create concise travel tags for this journal entry: \(entry.title). \(entry.body)",
                generating: SmartTags.self
            )
            return result.content
        } catch {
            throw AIError.generationFailed
        }
    }
}
