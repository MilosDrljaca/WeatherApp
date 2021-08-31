//
//  File.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 31.8.21..
//

import Foundation

class HomePresenter {
    
    var cityList: [Parent] = []
    weak var homeVC: HomeController?
    
    init(viewController: HomeController){
        DataPreparation.getCityListData()
        self.homeVC = viewController
        self.cityList = DataPreparation.cityList
    }
    
    func getCityListSize() -> Int{
        return cityList.count
    }
    
    func getCityList() -> [Parent]{
        return cityList
    }
    
    func getCity(position: Int) -> Parent{
        return cityList[position]
    }
}
