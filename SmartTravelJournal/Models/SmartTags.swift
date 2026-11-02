import Foundation
import FoundationModels

@Generable
struct SmartTags {
    @Guide(description: "A list of short relevant travel tags, such as food, culture, nature, adventure.")
    var tags: [String]
}
