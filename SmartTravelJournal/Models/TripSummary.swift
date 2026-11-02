import Foundation
import FoundationModels

@Generable
struct TripSummary {
    @Guide(description: "A friendly summary of the travel experience in two or three sentences.")
    var summary: String
    @Guide(description: "A memorable highlight from the trip.")
    var highlight: String
    @Guide(description: "One useful travel recommendation.")
    var recommendation: String
}
