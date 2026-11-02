import SwiftUI
import SwiftData

struct JournalEntryDetailView: View {
    @Bindable var entry: JournalEntry
    @State private var tagViewModel = SmartTagViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(entry.mood.emoji).font(.system(size: 46))
                Text(entry.timestamp.formatted(date: .complete, time: .shortened))
                    .foregroundStyle(.secondary)
                Text(entry.body)
                if !entry.smartTags.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack { ForEach(entry.smartTags, id: \.self) { TagChipView(tag: $0) } }
                    }
                }
                Button {
                    Task { await tagViewModel.generate(for: entry) }
                } label: {
                    if tagViewModel.isGenerating { ProgressView() }
                    else { Label("Generate Smart Tags", systemImage: "sparkles") }
                }
                if !tagViewModel.tags.isEmpty {
                    HStack { ForEach(tagViewModel.tags, id: \.self) { TagChipView(tag: $0) } }
                }
                if let error = tagViewModel.errorMessage {
                    Text(error).font(.caption).foregroundStyle(.red)
                }
            }.padding()
        }
        .navigationTitle(entry.title)
        .animation(.easeInOut, value: tagViewModel.tags)
    }
}
