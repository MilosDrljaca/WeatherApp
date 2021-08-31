//
//  DataPreparation.swift
//  WeatherApp
//
//  Created by milos.drljaca on 31.8.21..
//

import Foundation
import CoreData

class DataPreparation{

    static var cityList: [Parent] = []
    static var locationWeather: LocationWeather?
    
    // MARK: For City
    static func getCityListData(){
        
        URLSession.shared.dataTask(with: cityListURLQuerry(), completionHandler: { (data, response, error) in
            if let data = data, let city: [Parent] = try? JSONDecoder().decode([Parent].self, from: data){
                
                cityList = city
                print(city)
            }
        }
        ).resume()
    }
    
    static func cityListURLQuerry() -> URL{
        return URL(string:
                    "https://www.metaweather.com/api/location/search/?query=usa"
        )!
    }
    
    // MARK: For Location Weather
    static func getlocationWeatherData(){
        
        URLSession.shared.dataTask(with: LocationWeatherURLQuerry(), completionHandler: { (data, response, error) in
            if let data = data, let weather: LocationWeather = try? JSONDecoder().decode(LocationWeather.self, from: data){
                
                locationWeather = weather
                print(weather)
            }
        }
        )
        .resume()
    }
    
    static func LocationWeatherURLQuerry() -> URL{
        return URL(string:
                    "https://www.metaweather.com/api/location/44418/"
        )!
    }
}
