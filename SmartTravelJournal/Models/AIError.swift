import Foundation

enum AIError: Error, LocalizedError {
    case unavailable
    case generationFailed

    var errorDescription: String? {
        switch self {
        case .unavailable: "Apple Intelligence is unavailable on this device."
        case .generationFailed: "The AI could not generate a travel insight. Please try again."
        }
    }
}
