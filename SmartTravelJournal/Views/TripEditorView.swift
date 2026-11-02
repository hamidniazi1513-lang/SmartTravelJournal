import SwiftUI
import SwiftData

struct TripEditorView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = TripsViewModel()
    @State private var title = ""
    @State private var destination = ""
    @State private var startDate = Date()
    @State private var endDate = Calendar.current.date(byAdding: .day, value: 4, to: .now) ?? .now

    var body: some View {
        Form {
            TextField("Trip title", text: $title)
            TextField("Destination", text: $destination)
            DatePicker("Start", selection: $startDate, displayedComponents: .date)
            DatePicker("End", selection: $endDate, in: startDate..., displayedComponents: .date)
        }
        .navigationTitle("New Trip")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.createTrip(title: title, destination: destination,
                        startDate: startDate, endDate: endDate, context: context)
                    dismiss()
                }.disabled(title.isEmpty || destination.isEmpty)
            }
        }
    }
}
