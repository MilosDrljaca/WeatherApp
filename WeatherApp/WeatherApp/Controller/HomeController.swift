//
//  ViewController.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 31.8.21..
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataPreparation.getCityListData()
        DataPreparation.getlocationWeatherData()
        print(DataPreparation.cityList)
        print(DataPreparation.locationWeather)

    }


}

