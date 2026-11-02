import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack { TripListView() }
                .tabItem { Label("Trips", systemImage: "airplane") }
            NavigationStack { MapTabView() }
                .tabItem { Label("Map", systemImage: "map") }
            NavigationStack { ChartsTabView() }
                .tabItem { Label("Charts", systemImage: "chart.xyaxis.line") }
        }
        .tint(.indigo)
    }
}
