import SwiftUI
import SwiftData
import MapKit

struct MapTabView: View {
    @Query private var trips: [Trip]
    @Query private var journalEntries: [JournalEntry]
    @State private var cameraPosition: MapCameraPosition = .automatic
    @State private var locationManager = LocationManager()

    var body: some View {
        Map(position: $cameraPosition) {
            ForEach(trips) { trip in
                Marker(trip.destination, coordinate: CLLocationCoordinate2D(
                    latitude: trip.latitude, longitude: trip.longitude))
                    .tint(.indigo)
            }
            ForEach(journalEntries) { entry in
                if let latitude = entry.latitude, let longitude = entry.longitude {
                    Annotation(entry.title, coordinate: CLLocationCoordinate2D(
                        latitude: latitude, longitude: longitude)) {
                        VStack(spacing: 3) {
                            Image(systemName: "book.closed.fill")
                                .foregroundStyle(.white).padding(8)
                                .background(.orange, in: Circle())
                            Text(entry.title).font(.caption2).padding(4)
                                .background(.regularMaterial, in: Capsule())
                        }
                    }
                }
            }
            if let location = locationManager.location {
                Marker("My Location", coordinate: location.coordinate).tint(.blue)
            }
        }
        .mapControls { MapCompass(); MapScaleView(); MapUserLocationButton() }
        .overlay(alignment: .bottomTrailing) {
            Button {
                locationManager.requestPermissionAndLocation()
                if let location = locationManager.location {
                    withAnimation {
                        cameraPosition = .region(MKCoordinateRegion(center: location.coordinate,
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)))
                    }
                }
            } label: {
                Image(systemName: "location.fill").padding(13)
                    .background(.regularMaterial, in: Circle())
            }
            .padding()
            .accessibilityLabel("Show my location")
        }
        .navigationTitle("Travel Map")
    }
}
