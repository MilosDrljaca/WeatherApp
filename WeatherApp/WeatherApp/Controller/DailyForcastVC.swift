//
//  DailyForcastVC.swift
//  WeatherApp
//
//  Created by milos.drljaca on 31.8.21..
//

import UIKit

class DailyForcastVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    lazy var dailyForcastPresenter: DailyForcastPresenter = DailyForcastPresenter(dailyForcastVC: self, dailyForcast: DataPreparation.locationWeather!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDailyForcastInfo()
    }
    
    // MARK: Labels for main view
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var mainTemperatureLabel: UILabel!
    @IBOutlet var mainWeatherState: UILabel!
    @IBOutlet var mainMinTemperatureLabel: UILabel!
    @IBOutlet var mainMaxTemperatureLabel: UILabel!
    
    // MARK: Labels for secundary view
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    @IBOutlet var dailyForcastTableView: UITableView!
    
    // MARK: Table View - Number of row in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForcastPresenter.getDailyForcastConsolidatedWeatherSize()
    }
    
    // MARK: Table View - Cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfigData.cellForDailyForcast, for: indexPath) as! CellForDailyForcastTV
        
        let consolidatedWeather = dailyForcastPresenter.getDailyForcast().consolidatedWeather.reversed()[indexPath.row]
        
        cell.humidityLabel.text = consolidatedWeather.humidity.description + " %"
        cell.temperatureLabel.text = getWholeNumber(string: consolidatedWeather.theTemp.description) + " °"
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(consolidatedWeather.weatherStateAbbr).png"){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data{
                    DispatchQueue.main.async {
                        cell.imageLabel.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        cell.timeLabel.text = getHourFromDateTime(dailyForcastCreated: consolidatedWeather.created.description) + " h"
        
        return cell
    }
    
    // MARK: Table View - Height For Row At
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: Getting inital forcast info
    func getDailyForcastInfo() {
        cityLabel.text = dailyForcastPresenter.getDailyForcast().title
        dateLabel.text = getDateFromDateTime(dailyForcastCreated: dailyForcastPresenter.getDailyForcast().consolidatedWeather[1].created.description)
        
        let consolidatedWeather = dailyForcastPresenter.getDailyForcast().consolidatedWeather[0]

        windSpeedLabel.text = getWholeNumber(string: consolidatedWeather.windSpeed.description) + " mph"
        mainTemperatureLabel.text = getWholeNumber(string: consolidatedWeather.theTemp.description) + " °"
        mainMinTemperatureLabel.text = getWholeNumber(string: consolidatedWeather.minTemp.description) + " °"
        mainMaxTemperatureLabel.text = getWholeNumber(string: consolidatedWeather.maxTemp.description) + " °"
        mainWeatherState.text = consolidatedWeather.weatherStateName
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(consolidatedWeather.weatherStateAbbr).png"){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data{
                    DispatchQueue.main.async {
                        print(data)
                        self.mainImage.image =  UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    // MARK: Getting hour from Api date
    func getHourFromDateTime(dailyForcastCreated: String) -> String{
        
        let dateFormater = DateFormatter()
        
        dateFormater.dateFormat = ConfigData.dateTimeFormat
        dateFormater.locale = Locale(identifier: ConfigData.dateTimeFormatLocale)
        
        if let hour = dateFormater.date(from: dailyForcastCreated){
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "HH"
            let newHour = newDateFormatter.string(from: hour)

            return newHour
        }
        return ""
    }
    
    // MARK: Getting simple date from Api date
    func getDateFromDateTime(dailyForcastCreated: String) -> String{
        
        let dateFormater = DateFormatter()
        
        dateFormater.dateFormat = ConfigData.dateTimeFormat
        dateFormater.locale = Locale(identifier: ConfigData.dateTimeFormatLocale)
        
        if let date = dateFormater.date(from: dailyForcastCreated){
            let newDateFormatter = DateFormatter()
            newDateFormatter.dateFormat = "MMM dd, yyyy"
            let newDate = newDateFormatter.string(from: date)
            
            return newDate
        }
        return ""
    }
    
    // MARK: Table View - Did select row at
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let consolidatedWeather = dailyForcastPresenter.getDailyForcast().consolidatedWeather[indexPath.row]
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(consolidatedWeather.weatherStateAbbr).png"){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data{
                    DispatchQueue.main.async {
                        print(data)
                        self.mainImage.image =  UIImage(data: data)
                    }
                }
                
            }.resume()
        }
        mainTemperatureLabel.text = getWholeNumber(string: consolidatedWeather.theTemp.description) + " °"
        mainMinTemperatureLabel.text = getWholeNumber(string: consolidatedWeather.minTemp.description) + " °"
        mainMaxTemperatureLabel.text = getWholeNumber(string: consolidatedWeather.maxTemp.description) + " °"
        mainWeatherState.text = consolidatedWeather.weatherStateName
    }
    
    func getWholeNumber(string: String) -> String {
        let delimiter = "."
        let value = string.components(separatedBy: delimiter)
        return value[0]
    }
}
