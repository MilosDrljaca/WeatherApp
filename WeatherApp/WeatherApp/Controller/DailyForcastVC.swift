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
    
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var mainTemperatureLabel: UILabel!
    
    @IBOutlet var mainWeatherState: UILabel!
    @IBOutlet var mainMinTemperatureLabel: UILabel!
    @IBOutlet var mainMaxTemperatureLabel: UILabel!
    
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var dailyForcastTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyForcastPresenter.getDailyForcast().consolidatedWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellForDailyForcast", for: indexPath) as! CellForDailyForcastTV
        
        
        let dailyForcast = dailyForcastPresenter.getDailyForcast().consolidatedWeather[indexPath.row]
        
        cell.humidityLabel.text = dailyForcast.humidity.description + " %"
        cell.temperatureLabel.text = dailyForcast.theTemp.description.prefix(2) + " °"
        
        
        if let url = URL(string: "https://www.metaweather.com/static/img/weather/png/64/\(dailyForcast.weatherStateAbbr).png"){
            URLSession.shared.dataTask(with: url){ (data,response,error) in
                if let data = data{
                    DispatchQueue.main.async {
                        print(data)
                        cell.imageLabel.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
        
        cell.timeLabel.text = getHourFromDateTime(dailyForcastCreated: dailyForcast.created.description) + " h"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func getDailyForcastInfo() {
        cityLabel.text = dailyForcastPresenter.getDailyForcast().title
        dateLabel.text = getDateFromDateTime(dailyForcastCreated: dailyForcastPresenter.getDailyForcast().time.description)
        timeLabel.text = dailyForcastPresenter.getDailyForcast().timezoneName
        
        let dailyForcast = dailyForcastPresenter.getDailyForcast().consolidatedWeather[0]
        
        mainTemperatureLabel.text = dailyForcast.theTemp.description.prefix(2) + " °"
        mainMinTemperatureLabel.text = dailyForcast.minTemp.description.prefix(2) + " °"
        mainMaxTemperatureLabel.text = dailyForcast.maxTemp.description.prefix(2) + " °"
        
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
        mainWeatherState.text = dailyForcast.weatherStateName
    }
    
    func getHourFromDateTime(dailyForcastCreated: String) -> String{
        
        let start = dailyForcastCreated.index(dailyForcastCreated.startIndex, offsetBy: 11)
        let end = dailyForcastCreated.index(dailyForcastCreated.endIndex, offsetBy: -14)
        let range = start..<end
        
        let hour = String(dailyForcastCreated[range])
        
        return hour
    }
    
    func getDateFromDateTime(dailyForcastCreated: String) -> String{
        
        let start = dailyForcastCreated.index(dailyForcastCreated.startIndex, offsetBy: 0)
        let end = dailyForcastCreated.index(dailyForcastCreated.endIndex, offsetBy: -22)
        let range = start..<end
        
        let hour = String(dailyForcastCreated[range])
        
        return hour
    }
    
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
