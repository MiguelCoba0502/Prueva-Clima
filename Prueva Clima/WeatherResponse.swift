//
//  WeatherResponse.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 23/10/24.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinates
    let weather: [WeatherDetail]
    let main: MainWeather
    let wind: Wind
    let clouds: Clouds
    let sys: Sys
    let name: String
}
struct Coordinates: Codable{
    let lon: Double
    let lat: Double
}
struct WeatherDetail: Codable{
    let main: String?
    let description: String?
    let icon: String?
    let id: Int?
    
}
struct MainWeather: Codable{
    let temp:Double?
    let feels_like:Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Int?
    let humidaty: Int?
    
}
struct Wind: Codable{
    let speed: Double?
    let deg: Int?
    let gust: Double?
    
}
struct Clouds: Codable{
    let all: Int?
    
}
struct Sys: Codable{
    let country: String?
    let sunrise: Int?
    let sunset: Int?
    
}
