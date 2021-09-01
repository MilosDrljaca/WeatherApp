//
//  CellForDailyForcastTV.swift
//  WeatherApp
//
//  Created by milos.drljaca on 31.8.21..
//

import UIKit

class CellForDailyForcastTV: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBOutlet var imageLabel: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
}
