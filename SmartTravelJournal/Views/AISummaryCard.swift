import SwiftUI

struct AISummaryCard: View {
    let summary: String
    let isLoading: Bool
    let errorMessage: String?
    let onGenerate: () -> Void
    let onRetry: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label("AI Trip Insight", systemImage: "sparkles").font(.headline)
            if isLoading {
                ProgressView("Creating your travel summary…")
            } else if !summary.isEmpty {
                Text(summary).font(.body)
            } else {
                Text("Generate a personalized summary and travel highlight.")
                    .foregroundStyle(.secondary)
            }
            if let errorMessage {
                Text(errorMessage).font(.caption).foregroundStyle(.red)
                Button("Retry", action: onRetry)
            } else if summary.isEmpty && !isLoading {
                Button("Generate Summary", action: onGenerate)
                    .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .contain)
    }
}
