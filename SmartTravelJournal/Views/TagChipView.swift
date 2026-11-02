import SwiftUI

struct TagChipView: View {
    let tag: String
    var body: some View {
        Text("#\(tag)")
            .font(.caption.weight(.semibold))
            .padding(.horizontal, 11).padding(.vertical, 7)
            .background(.indigo.opacity(0.12), in: Capsule())
            .accessibilityLabel("Tag \(tag)")
    }
}
