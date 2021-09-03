//
//  WeeklyForcastVC.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 2.9.21..
//

import UIKit

class WeeklyForcastVC: UIViewController {

    @IBOutlet var selectedCityLabel: UILabel!
    @IBOutlet var weeklyForecastTableView: UITableView!
    
    lazy private var weeklyForcastPresenter: WeeklyForecastPresenter
        = WeeklyForecastPresenter(weeklyForcastViewC: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        weeklyForcastPresenter.sortWeatherByDate(weeklyForcast: DataPreparation.weeklyWeather)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        selectedCityLabel.text = DataPreparation.selectedCity?.title
    }
}

extension WeeklyForcastVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weeklyForcastPresenter.countDaysInWeek()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dayInWeek", for: indexPath) as! CellForWeeklyForecastTV
        
        cell.dateInWeek.text = weeklyForcastPresenter.getDayInWeek(position: indexPath.row)
        cell.minTemperature.text
            = weeklyForcastPresenter.getMinTempForDay(position: indexPath.row)
        cell.maxTemperature.text
            = weeklyForcastPresenter.getMaxTempForDay(position: indexPath.row)
        
        if indexPath.row % 2 == 0{
            cell.backgroundColor = .systemGray6
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(identifier: "DailyForcastVC") as! DailyForcastVC
        vc.modalPresentationStyle = .formSheet
        
        var day = DataPreparation.locationWeather
        day!.consolidatedWeather = weeklyForcastPresenter.getWeatherForDay(position: indexPath.row)
        vc.dailyForcastPresenter.setDailyForcast(daily: day!)
        self.present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
}
