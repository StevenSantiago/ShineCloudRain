//
//  Constants.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/26/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let API_KEY = "ff82d3e39be4c32ba3b17f762ebffef4"

let FORECAST_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=21&lon=23&cnt=10&mode=json&appid=ff82d3e39be4c32ba3b17f762ebffef4"


typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)21\(LONGITUDE)23\(APP_ID)\(API_KEY)"


