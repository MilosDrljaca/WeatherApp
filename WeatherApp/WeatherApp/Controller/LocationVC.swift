//
//  LocationVC.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 1.9.21..
//

import UIKit

class LocationVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DataPreparation.getlocationWeatherData()
        print("Ovo je sacuvani grad \(DataPreparation.selectedCity)")
    }

}
