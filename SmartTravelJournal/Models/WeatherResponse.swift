import Foundation

struct WeatherResponse: Codable {
    let name: String
    let main: Main
    let weather: [Weather]

    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let humidity: Int
        enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case humidity
        }
    }

    struct Weather: Codable, Identifiable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }

    // The app uses Open-Meteo's free endpoint; this decoder adapts its current-weather
    // payload to the familiar name/main/weather model used by the views.
    enum CodingKeys: String, CodingKey { case name, main, weather, current }
    enum CurrentKeys: String, CodingKey {
        case temperature2m = "temperature_2m"
        case apparentTemperature = "apparent_temperature"
        case relativeHumidity2m = "relative_humidity_2m"
        case weatherCode = "weather_code"
    }

    init(name: String, main: Main, weather: [Weather]) {
        self.name = name
        self.main = main
        self.weather = weather
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let decodedName = try container.decodeIfPresent(String.self, forKey: .name),
           let decodedMain = try container.decodeIfPresent(Main.self, forKey: .main),
           let decodedWeather = try container.decodeIfPresent([Weather].self, forKey: .weather) {
            name = decodedName
            main = decodedMain
            weather = decodedWeather
            return
        }
        let current = try container.nestedContainer(keyedBy: CurrentKeys.self, forKey: .current)
        let temperature = try current.decode(Double.self, forKey: .temperature2m)
        let apparent = try current.decode(Double.self, forKey: .apparentTemperature)
        let humidity = try current.decode(Int.self, forKey: .relativeHumidity2m)
        let code = try current.decode(Int.self, forKey: .weatherCode)
        name = "Selected destination"
        main = Main(temp: temperature, feelsLike: apparent, humidity: humidity)
        weather = [Weather(id: code, main: "Current", description: "Weather code \(code)", icon: "")]
    }
}
