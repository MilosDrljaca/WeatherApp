//
//  WeeklyForecastPresenter.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 2.9.21..
//

import Foundation

class WeeklyForecastPresenter{
    
    private var weeklyForcast: [Int : Dictionary<String, [ConsolidatedWeather]>.Element] = [:]
    weak private var weeklyForecastVC: WeeklyForcastVC?
    
    init(weeklyForcastViewC: WeeklyForcastVC) {
        self.weeklyForecastVC = weeklyForcastViewC
    }
    
    func sortWeatherByDate(weeklyForcast: [ConsolidatedWeather]){
        var tempArray: [String: [ConsolidatedWeather]] = [:]
        
        firstLoop: for forecast in weeklyForcast{
            let date = forecast.created.components(separatedBy: "T")
            var array: [ConsolidatedWeather] = []
            
            secondLoop: for weather in weeklyForcast{
                let tempDate = weather.created.components(separatedBy: "T")[0]
//                if tempArray.keys.contains(tempDate){
//                    dateExist = true
//                    break firstLoop
//                }
                if tempDate == date[0]{
                    array.append(weather)
                }
            }

            tempArray["\(date[0])"] = array
        }

        let sorted = tempArray.sorted(by: { $0.0.compare($1.0) == .orderedDescending })

        for  (i, s) in sorted.enumerated(){
            self.weeklyForcast[i] = s
        }
       
    }
    
    func countDaysInWeek() -> Int{
        return weeklyForcast.count
    }
   
    func getDayInWeek(position: Int) -> String?{
        return weeklyForcast[position]?.0
    }
    
    func getWeatherForDay(position: Int) -> [ConsolidatedWeather]{
        return weeklyForcast[position]!.value
    }
    
    func getMinTempForDay(position: Int) -> String{
        
        let weeklyForecast: [ConsolidatedWeather] = getWeatherForDay(position: position)
        var minT = 0.0
        
        for forecast in weeklyForecast{
            if forecast.minTemp > minT{
                minT = forecast.minTemp
            }
        }
        
        return String(format: "%.2f", minT) + " °C"
    }
    
    func getMaxTempForDay(position: Int) -> String{
        
        let weeklyForecast: [ConsolidatedWeather] = getWeatherForDay(position: position)
        var maxT = 0.0
        
        for forecast in weeklyForecast{
            if forecast.maxTemp > maxT{
                maxT = forecast.maxTemp
            }
        }
        
        return String(format: "%.2f", maxT) + " °C"
    }
}
