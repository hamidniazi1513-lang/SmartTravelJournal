import SwiftUI
import SwiftData

struct TripListView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Trip.startDate, order: .reverse) private var trips: [Trip]
    @State private var viewModel = TripsViewModel()
    @State private var showingEditor = false

    private var filtered: [Trip] { viewModel.filteredTrips(trips) }

    var body: some View {
        List {
            if filtered.isEmpty {
                ContentUnavailableView("No Trips", systemImage: "airplane",
                    description: Text("Add your first trip to start your journal."))
            }
            ForEach(filtered) { trip in
                NavigationLink {
                    TripDetailView(trip: trip)
                } label: {
                    HStack(spacing: 12) {
                        Image(systemName: trip.coverImageName)
                            .font(.title2).foregroundStyle(.indigo)
                            .frame(width: 48, height: 48)
                            .background(.indigo.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
                        VStack(alignment: .leading, spacing: 4) {
                            Text(trip.title).font(.headline)
                            Text(trip.destination).font(.subheadline).foregroundStyle(.secondary)
                            Text(trip.startDate.formatted(date: .abbreviated, time: .omitted))
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .padding(.vertical, 3)
                    .accessibilityHint("Opens the trip and its journal entries")
                    .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }
            .animation(.snappy, value: filtered.count)
            .onDelete { offsets in
                for index in offsets { viewModel.deleteTrip(filtered[index], context: context) }
            }
        }
        .navigationTitle("Travel Journal")
        .searchable(text: $viewModel.searchText, prompt: "Search trips")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { showingEditor = true } label: { Image(systemName: "plus") }
                    .accessibilityLabel("Create trip")
            }
        }
        .sheet(isPresented: $showingEditor) {
            NavigationStack { TripEditorView() }
        }
    }
}
