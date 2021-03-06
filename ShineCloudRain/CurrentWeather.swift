//
//  CurrentWeather.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/26/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
// Keeps track of weather variables

import UIKit
import Alamofire

class CurrentWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp:Double!
    
    var  cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var  date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        return _date
    }
    
    var  weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var  currentTemp: Double {
        if _currentTemp == nil {
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed:@escaping DownloadComplete){
        //Alamofire download
        Alamofire.request(CURRENT_WEATHER_URL).responseJSON { response in // requesting the info from URL
            let result = response.result
            //print(result)
            // parsing through data
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = weather[0]["main"] as? String {
                        self._weatherType = main
                        print(self._weatherType)
                    }
                }
                
                if let main = dict ["main"] as? Dictionary<String,AnyObject> {
                    if let currentTemperature = main["temp"] as? Double {                        
                        self._currentTemp = kelvinToFahrenheit(_value: currentTemperature)
                        print(self._currentTemp)
                    }
                }
                
            }
            completed()
        }
        
    }
}


