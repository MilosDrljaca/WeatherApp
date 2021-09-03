//
//  CellForWeeklyForcastTV.swift
//  WeatherApp
//
//  Created by aleksandar.aleksic on 3.9.21..
//

import UIKit

class CellForWeeklyForecastTV: UITableViewCell {

    @IBOutlet var dateInWeek: UILabel!
    @IBOutlet var minTemperature: UILabel!
    @IBOutlet var maxTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
