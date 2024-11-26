//
//  WeatherView.swift
//  Prueva Clima
//
//  Created by Eduardo Coba on 29/10/24.
//

import SwiftUI


struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()

    
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: viewModel.isDaytime ? [Color.blue, Color.white] : [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom) .edgesIgnoringSafeArea(.all)
            
            VStack{
                
                SearchBar(text: $viewModel.searchQuery){
                  Task{
                    await viewModel.fetchWeatherByCity(city: viewModel.searchQuery)
                    }
                }
                if viewModel.isSearching{
                    ProgressView("Buscando...")
                } else {
                    VStack{
                        Text(viewModel.locationName)
                            .font(.largeTitle)
                            .padding(.top)
                       
                        Image(systemName: getWeatherIcon(for: viewModel.weatherDescription))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding(.top)
                        
                        Text(viewModel.currentTemperature)
                            .font(.system(size: 72, weight: .semibold))
                            .padding(.top)
                        
                        Text(viewModel.weatherDescription)
                            .font(.title)
                            .padding(.bottom)
                        
                        Spacer()
                    }
                    .foregroundStyle(.white)
                }
            }.onAppear{ 
                Task{
                   await viewModel.fetchWeatherByLocation(latitude: 19.8342, longitude: -101.1234)
                }
            }
        }
        
    }
    
    func getWeatherIcon(for description: String) -> String {
        switch description.lowercased(){
            
        case "clear sky":
            return "sun.max.fill"
        case "few clouds":
            return"cloud.sun.fill"
        case "scattered clouds", "broken clouds", "overcast clouds":
            return "cloud.fill"
        case "rain", "light rain", "moderate rain":
            return "cloud.rain.fill"
        case "thunderstorm":
            return"cloud,bolt.fill"
        case "snow":
            return"cloud.snow.fill"
        case "mist":
            return"cloud.mist.fill"
        default:
            return "cloud"
        }
    }
    
    
}

#Preview {
    WeatherView()
}
