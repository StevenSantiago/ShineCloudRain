//
//  Forecast.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/27/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit
import Alamofire

class Forecast {
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }
    
    init(weatherDict : Dictionary<String,AnyObject>) {
        if let temp = weatherDict["temp"] as? Dictionary<String,AnyObject>{
            if let min = temp["min"] as? Double {
                let preKelvinToFarenheit = (min) * (9/5) - 459.67
                
                let Farenheit = Double(round(10 * preKelvinToFarenheit/10))
                
                self._lowTemp = String(Farenheit)
            }
            
            if let max = temp["max"] as? Double {
                let preKelvinToFarenheit = (max) * (9/5) - 459.67
                
                let Farenheit = Double(round(10 * preKelvinToFarenheit/10))
                
                self._highTemp = String(Farenheit)
            }
            
        }
        
        if let weather = weatherDict ["weather"] as? [Dictionary<String,AnyObject>] {
            if let main = weather[0]["main"] as? String {
                self._weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date  = unixConvertedDate.dayOfTheWeek()
        }
    }
    
    
}

extension Date {
    func dayOfTheWeek () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
