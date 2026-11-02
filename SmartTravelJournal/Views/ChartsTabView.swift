import SwiftUI
import SwiftData
import Charts

struct ChartsTabView: View {
    @Query private var trips: [Trip]
    @Query(sort: \JournalEntry.timestamp) private var entries: [JournalEntry]

    private var monthlyCounts: [MonthlyEntryCount] {
        let grouped = Dictionary(grouping: entries) {
            Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: $0.timestamp)) ?? $0.timestamp
        }
        return grouped.map { MonthlyEntryCount(month: $0.key, count: $0.value.count) }
            .sorted { $0.month < $1.month }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    StatCard(title: "Trips", value: "\(trips.count)", systemImage: "airplane")
                    StatCard(title: "Memories", value: "\(entries.count)", systemImage: "book")
                }
                Text("Journal activity").font(.headline)
                if monthlyCounts.isEmpty {
                    ContentUnavailableView("No Journal Data", systemImage: "chart.xyaxis.line",
                        description: Text("Add journal entries to see your travel activity."))
                        .frame(height: 210)
                } else {
                    Chart(monthlyCounts) { item in
                        AreaMark(x: .value("Month", item.month), y: .value("Entries", item.count))
                            .foregroundStyle(.indigo.opacity(0.18))
                        LineMark(x: .value("Month", item.month), y: .value("Entries", item.count))
                            .foregroundStyle(.indigo)
                            .symbol(.circle)
                    }
                    .frame(height: 230)
                    .chartXAxis { AxisMarks(values: .automatic(desiredCount: 5)) }
                    .accessibilityLabel("Area and line chart of journal entries by month")
                }
                Text("Destinations").font(.headline)
                ForEach(trips) { trip in
                    HStack {
                        Image(systemName: "mappin.and.ellipse").foregroundStyle(.indigo)
                        Text(trip.destination)
                        Spacer()
                        Text("\(trip.entries.count) memories").foregroundStyle(.secondary)
                    }
                }
            }.padding()
        }
        .navigationTitle("Travel Charts")
    }
}

struct MonthlyEntryCount: Identifiable {
    let month: Date
    let count: Int
    var id: Date { month }
}
