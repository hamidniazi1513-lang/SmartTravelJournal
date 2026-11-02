import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 9) {
            Label(title, systemImage: systemImage)
                .font(.caption).foregroundStyle(.secondary)
            Text(value).font(.largeTitle.bold())
                .contentTransition(.numericText())
                .accessibilityLabel("\(title): \(value)")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.indigo.opacity(0.10), in: RoundedRectangle(cornerRadius: 16))
    }
}
