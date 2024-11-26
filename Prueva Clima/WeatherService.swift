//
//  WeatherService.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 23/10/24.
//

import Foundation
import Combine

class WeatherService{
    private let apiKey = "d9d6666fe476c3bc16d37b5c89bb4bef"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"
    
    let service = RemoteServiceManager()
    
    func fetchWeatherByCity(city: String) async throws -> WeatherResponse{
        let urlString = "\(baseUrl)?q=\(city)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else{
          throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let request = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = request.1 as? HTTPURLResponse
        else { throw APIError.unknownError }
        print(httpResponse.statusCode)
        let decoder = JSONDecoder()
        let model = try decoder.decode(WeatherResponse.self, from: request.0)
        return model
        
    }
    
   
    func fetchWeatherByLocation(latitude: Double, longitude: Double) async throws -> WeatherResponse{
        let urlString = "\(baseUrl)?lat=\(latitude)&lon=\(longitude)&units=metric&appid=\(apiKey)"
        guard let url = URL(string: urlString) else{
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        let request = try await URLSession.shared.data(for: urlRequest)
        guard let httpResponse = request.1 as? HTTPURLResponse
        else { throw APIError.unknownError }
        print(httpResponse.statusCode)
        let decoder = JSONDecoder()
        let model = try decoder.decode(WeatherResponse.self, from: request.0)
        return model
        
        //return try await service.resquest(request: urlRequest)
    }
}

    
