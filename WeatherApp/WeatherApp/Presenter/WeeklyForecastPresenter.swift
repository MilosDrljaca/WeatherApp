//
//  WeeklyForecastPresenter.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 2.9.21..
//

import Foundation

class WeeklyForecastPresenter{
    
    private var weeklyForcast: [Dictionary<String, [ConsolidatedWeather]>.Element]?
    weak private var weeklyForecastVC: WeeklyForcastVC?
    
    init(weeklyForcastViewC: WeeklyForcastVC) {
        self.weeklyForecastVC = weeklyForcastViewC
    }
    
    func sortWeatherByDate(weeklyForcast: [ConsolidatedWeather]){
        var tempArray: [String: [ConsolidatedWeather]] = [:]
        
        for forecast in weeklyForcast{
            let date = forecast.created.components(separatedBy: "T")
            var array: [ConsolidatedWeather] = []

            weeklyForcast.forEach { weather in
                if weather.created.components(separatedBy: "T")[0] == date[0]{
                    array.append(weather)
                }
            }
            
            tempArray["\(date[0])"] = array
        }

        let sorted = tempArray.sorted(by: { $0.0.compare($1.0) == .orderedDescending })

        self.weeklyForcast = sorted
       
    }
    
}
