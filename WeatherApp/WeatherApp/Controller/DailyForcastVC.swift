//
//  DailyForcastVC.swift
//  WeatherApp
//
//  Created by milos.drljaca on 31.8.21..
//

import UIKit

class DailyForcastVC: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    lazy private var dailyForcastPresenter: DailyForcastPresenter = DailyForcastPresenter(dailyForcastVC: self, dailyForcast: DataPreparation.locationWeather!)
    
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
        return dailyForcastPresenter.getDailyForcast().consolidatedWeather.count
    }
    
    // MARK: Table View - Cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ConfigData.cellForDailyForcast, for: indexPath) as! CellForDailyForcastTV
        
        let dailyForcast = dailyForcastPresenter.getDailyForcast().consolidatedWeather[indexPath.row]

        cell.humidityLabel.text = dailyForcast.humidity.description + " %"
        cell.temperatureLabel.text = dailyForcast.theTemp.description.prefix(2) + " °"
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(dailyForcast.weatherStateAbbr).png"){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data{
                    DispatchQueue.main.async {
                        cell.imageLabel.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        cell.timeLabel.text = getHourFromDateTime(dailyForcastCreated: dailyForcast.created.description) + " h"
        
        return cell
    }
    
    // MARK: Table View - Height For Row At
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // MARK: Getting inital forcast info
    func getDailyForcastInfo() {
        cityLabel.text = dailyForcastPresenter.getDailyForcast().title
        dateLabel.text = getDateFromDateTime(dailyForcastCreated: dailyForcastPresenter.getDailyForcast().time.description)
    
        let dailyForcast = dailyForcastPresenter.getDailyForcast().consolidatedWeather[0]

        windSpeedLabel.text = dailyForcast.windSpeed.description.prefix(2) + " mph"
        mainTemperatureLabel.text = dailyForcast.theTemp.description.prefix(2) + " °"
        mainMinTemperatureLabel.text = dailyForcast.minTemp.description.prefix(2) + " °"
        mainMaxTemperatureLabel.text = dailyForcast.maxTemp.description.prefix(2) + " °"
        mainWeatherState.text = dailyForcast.weatherStateName
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(dailyForcast.weatherStateAbbr).png"){
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
            newDateFormatter.dateFormat = "hh"
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
        let dailyForcast = dailyForcastPresenter.getDailyForcast().consolidatedWeather[indexPath.row]
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/\(dailyForcast.weatherStateAbbr).png"){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data{
                    DispatchQueue.main.async {
                        print(data)
                        self.mainImage.image =  UIImage(data: data)
                    }
                }
                
            }.resume()
        }
        mainTemperatureLabel.text = dailyForcast.theTemp.description.prefix(2) + " °"
        mainMinTemperatureLabel.text = dailyForcast.minTemp.description.prefix(2) + " °"
        mainMaxTemperatureLabel.text = dailyForcast.maxTemp.description.prefix(2) + " °" 
        mainWeatherState.text = dailyForcast.weatherStateName
    }
}
