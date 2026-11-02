import SwiftUI
import SwiftData

struct TripDetailView: View {
    @Bindable var trip: Trip
    @State private var summaryViewModel = TripSummaryViewModel()
    @State private var showingEntryEditor = false

    var body: some View {
        List {
            Section("Trip details") {
                LabeledContent("Destination", value: trip.destination)
                LabeledContent("Start", value: trip.startDate.formatted(date: .long, time: .omitted))
                LabeledContent("End", value: trip.endDate.formatted(date: .long, time: .omitted))
                if !trip.notes.isEmpty { Text(trip.notes) }
            }
            Section {
                AISummaryCard(summary: trip.aiSummary,
                    isLoading: summaryViewModel.isGenerating,
                    errorMessage: summaryViewModel.errorMessage,
                    onGenerate: { Task { await summaryViewModel.generate(for: trip) } },
                    onRetry: { Task { await summaryViewModel.retry(for: trip) } })
            } header: { Text("AI Travel Summary") }
            Section("Journal entries") {
                ForEach(trip.entries.sorted { $0.timestamp > $1.timestamp }) { entry in
                    NavigationLink {
                        JournalEntryDetailView(entry: entry)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(entry.title).font(.headline)
                            Text("\(entry.mood.emoji) \(entry.mood.rawValue) • \(entry.timestamp.formatted(date: .abbreviated, time: .shortened))")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
                Button { showingEntryEditor = true } label: {
                    Label("Add Journal Entry", systemImage: "plus")
                }
            }
        }
        .navigationTitle(trip.title)
        .task {
            if trip.aiSummary.isEmpty {
                await summaryViewModel.generate(for: trip)
            }
        }
        .sheet(isPresented: $showingEntryEditor) {
            NavigationStack { JournalEntryEditor(trip: trip) }
        }
    }
}
