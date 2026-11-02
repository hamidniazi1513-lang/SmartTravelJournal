import Foundation
import Observation

@MainActor
@Observable
final class SmartTagViewModel {
    var tags: [String] = []
    var isGenerating = false
    var errorMessage: String?

    func generate(for entry: JournalEntry) async {
        isGenerating = true
        errorMessage = nil
        defer { isGenerating = false }
        do {
            let result = try await AIService().generateSmartTags(for: entry)
            tags = result.tags
            entry.smartTags = result.tags
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
