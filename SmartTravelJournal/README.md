# SmartTravelJournal

Complete SwiftUI travel journal project for the capstone submission.

## Xcode
Open `SmartTravelJournal.xcodeproj` in Xcode 26 or later. The project targets iOS 26 because it uses SwiftData and Foundation Models. Select an iPhone simulator or device and build.

## Included
- SwiftData Trip and JournalEntry models with cascade relationship
- Computed mood property and CSV-backed smart tags
- MVVM view models for trips, journal entries, trip summaries, and smart tags
- Core Location manager and weather networking through Open-Meteo
- MapKit annotations for trip destinations and geotagged journal entries
- Swift Charts LineMark and AreaMark
- Reusable StatCard, AISummaryCard, and TagChipView
- Foundation Models generated trip summaries and smart tags
- Search, create, delete, accessibility labels, and animated updates

Weather uses the free Open-Meteo API and does not require an API key. Apple Intelligence features require a supported device and OS.
