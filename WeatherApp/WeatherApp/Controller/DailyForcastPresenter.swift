//
//  DailyForcastPresenter.swift
//  WeatherApp
//
//  Created by milos.drljaca on 31.8.21..
//

import Foundation

class DailyForcastPresenter{
    
    private var dailyForcast: LocationWeather
    weak private var dailyForcastVC: DailyForcastVC?
    
    init(dailyForcastVC: DailyForcastVC, dailyForcast: LocationWeather) {
        self.dailyForcastVC = dailyForcastVC
        self.dailyForcast = dailyForcast
    }
    
    func setDailyForcast(daily: LocationWeather){
        self.dailyForcast = daily
    }
    
    func getDailyForcast() -> LocationWeather{
        return dailyForcast
    }
    
    func getDailyForcastConsolidatedWeatherSize() -> Int{
        return dailyForcast.consolidatedWeather.count
    }
}
