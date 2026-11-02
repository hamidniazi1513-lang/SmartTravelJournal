import SwiftUI
import SwiftData
import CoreLocation

struct JournalEntryEditor: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    let trip: Trip
    @State private var viewModel = JournalEntryViewModel()
    @State private var locationManager = LocationManager()
    @State private var locationService = LocationService()
    @State private var title = ""
    @State private var entryBody = ""
    @State private var mood: JournalMood = .happy
    @State private var weatherText: String?
    @State private var locationError: String?

    var body: some View {
        Form {
            Section("Your memory") {
                TextField("Title", text: $title)
                TextField("What happened?", text: $entryBody, axis: .vertical).lineLimit(4...8)
                Picker("Mood", selection: $mood) {
                    ForEach(JournalMood.allCases) { item in
                        Text("\(item.emoji) \(item.rawValue)").tag(item)
                    }
                }
            }
            Section("Location & weather") {
                if let location = locationManager.location {
                    Text("Location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
                    Button("Fetch weather here") {
                        Task {
                            do {
                                let response = try await locationService.fetchWeather(for: location)
                                weatherText = "\(response.main.temp.formatted()) °C • \(response.weather.first?.description ?? "Current weather")"
                            } catch { locationError = error.localizedDescription }
                        }
                    }
                } else {
                    Button("Use Current Location") {
                        locationManager.requestPermissionAndLocation()
                    }
                }
                if let weatherText { Text(weatherText) }
                if let locationError { Text(locationError).foregroundStyle(.red) }
                if let locationManager.locationError {
                    Text(locationManager.locationError!).foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("Journal Entry")
        .toolbar {
            ToolbarItem(placement: .cancellationAction) { Button("Cancel") { dismiss() } }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    withAnimation(.spring()) {
                        viewModel.saveEntry(title: title, body: entryBody, mood: mood,
                            location: locationManager.location, trip: trip, context: context)
                    }
                    dismiss()
                }.disabled(title.isEmpty || entryBody.isEmpty)
            }
        }
    }
}
