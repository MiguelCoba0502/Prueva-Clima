//
//  WeatherViewModel.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 23/10/24.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject{
    @Published var currentTemperature: String = "--"
    @Published var weatherDescription: String = ""
    @Published var weatherId: Int = 800
    @Published var locationName: String = ""
    @Published var searchQuery: String = "" // para la busqueda por cieudad
    @Published var isSearching: Bool = false // Estado de busqueda
    @Published var isDaytime: Bool = true
    
    private var cancellables = Set<AnyCancellable> ()
    private let weatherService: WeatherService
    private let locationManager: LocationManager
    
    init(weatherService: WeatherService = WeatherService(), locationManager: LocationManager = LocationManager()) {
        self.weatherService = weatherService
        self.locationManager = locationManager
    }

    
    @MainActor
    func fetchWeatherByCity(city: String?) async {
        isSearching = true
        
        print("city: ",city)
        do{
            guard let city = city else { return }
            let result = try await weatherService.fetchWeatherByCity(city: city)
            print(result)
            updateWeatherData(response: result)
            isSearching = false
        }
        catch let error {
            print(error)
            isSearching = false
        }
        
    }
       
    
    @MainActor
    func fetchWeatherByLocation(latitude: Double?, longitude: Double?) async{
        isSearching = true
        do {
            guard let lat = latitude,let long = longitude else { return }
            let result = try await weatherService.fetchWeatherByLocation(latitude: lat, longitude: long)
            print(result)
            updateWeatherData(response: result)
            isSearching = false
        } catch let error {
            print(error)
            isSearching = false
        }
        
    }
    
    private func updateWeatherData(response: WeatherResponse){
        self.currentTemperature = "\(Int(response.main.temp ?? 0))°C"
        self.weatherDescription = response.weather.first?.description?.capitalized ?? ""
        self.locationName = response.name
        self.weatherId = response.weather.first?.id ?? 800
        
    }
    
    private func checkIfDaytime(){
        let calendar = Calendar.current
        let currenHour = calendar.component(.hour, from: Date())
        
        //si la hora es despues de las 7 PM o antes de las 8 PM, es de noche
        
        if currenHour >= 19 || currenHour < 8 {
            self.isDaytime = false
        }else{
            self.isDaytime = true
        }
            
    }
    
 
}
