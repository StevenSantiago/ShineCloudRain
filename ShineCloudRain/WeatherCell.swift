//
//  WeatherCell.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/28/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    func configureCell(forecast: Forecast) {
        lowTemp.text = String(forecast.lowTemp)
        highTemp.text = String(forecast.highTemp)
        weatherType.text = forecast.weatherType
        weatherIcon.image = UIImage(named: forecast.weatherType)
        dayLbl.text = forecast.date
    }


}
