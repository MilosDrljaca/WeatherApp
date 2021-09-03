//
//  WeeklyForcastVC.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 2.9.21..
//

import UIKit

class WeeklyForcastVC: UIViewController {

    lazy private var weeklyForcastPresenter: WeeklyForecastPresenter
        = WeeklyForecastPresenter(weeklyForcastViewC: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weeklyForcastPresenter.sortWeatherByDate(weeklyForcast: DataPreparation.weeklyWeather)
        print("Ovo je broj prognoza \(DataPreparation.weeklyWeather.count)")
    }

}
