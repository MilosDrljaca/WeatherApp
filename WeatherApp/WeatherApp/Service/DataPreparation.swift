//
//  DataPreparation.swift
//  WeatherApp
//
//  Created by milos.drljaca on 31.8.21..
//

import Foundation
import CoreData

class DataPreparation{

    static var selectedCity: Parent?
    static var cityList: [Parent] = []
    static var locationWeather: LocationWeather?
    static var weeklyWeather: [ConsolidatedWeather] = []
    
    // MARK: For City
    static func getCityListData(with query: String = ""){
        
        URLSession.shared.dataTask(with: cityListURLQuerry(query: query), completionHandler: { (data, response, error) in
            if let data = data, let city: [Parent] = try? JSONDecoder().decode([Parent].self, from: data){
                cityList = city
            }
        }).resume()
    }
    
    static func cityListURLQuerry(query text: String) -> URL{
        if text.contains(" "){
            return URL(string:"https://www.metaweather.com/api/location/search/?query=\(text.replacingOccurrences(of: " ", with: ""))")!
        }
        return URL(string:"https://www.metaweather.com/api/location/search/?query=\(text)")!
    }
    
    // MARK: For Location Weather
    static func getlocationWeatherData(){
        if let cityId = selectedCity?.woeid{
            URLSession.shared.dataTask(with: LocationWeatherURLQuerry(cityNumber: cityId), completionHandler: { (data, response, error) in
                if let data = data, let weather: LocationWeather = try? JSONDecoder().decode(LocationWeather.self, from: data){
                    
                    locationWeather = weather
                }
            }).resume()
        }
    }
    
    static func LocationWeatherURLQuerry(cityNumber: Int) -> URL{
        return URL(string:
                    "https://www.metaweather.com/api/location/\(cityNumber)/"
        )!
    }
    
    // MARK: ConsolidatedWeather Weekly forecast
    static func getConsolidatedWeatherData(){
        if let cityId = selectedCity?.woeid{
            URLSession.shared.dataTask(with: consolidatedWeatherURLQuerry(cityId: cityId), completionHandler: { (data, response, error) in
                if let data = data, let consolidatedWeathers: [ConsolidatedWeather] = try? JSONDecoder().decode([ConsolidatedWeather].self, from: data){
                    weeklyWeather = consolidatedWeathers
                }
            }).resume()
        }
    }
    
    static func consolidatedWeatherURLQuerry(cityId: Int) -> URL{
        return URL(string:"https://www.metaweather.com/api/location/\(cityId)/\(todayDate())")!
    }
    
    private static func todayDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from:Date())
    }
}
