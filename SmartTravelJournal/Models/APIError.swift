import Foundation

enum APIError: Error, LocalizedError {
    case networkUnavailable
    case invalidResponse
    case decodingFailed
    case serverError(Int)

    var errorDescription: String? {
        switch self {
        case .networkUnavailable: "The network is unavailable. Check your connection."
        case .invalidResponse: "The server response was invalid."
        case .decodingFailed: "The weather response could not be decoded."
        case .serverError(let code): "The weather server returned status \(code)."
        }
    }
}
