//
//  ViewController.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/24/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentLoc: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherDesc: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    
    var forecast : Forecast!
    
    private let numberOfCells = 6
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabelView.delegate = self
        tabelView.dataSource = self
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
            
        }
        
    }
    
    // func numberOfSections(in tableView: UITableView) -> Int {
    //   return 1
    // }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DataWeather", for: indexPath)
        return cell
    }
    
    func updateMainUI () {
        dateLbl.text = currentWeather.date
        currentTemp.text = String(currentWeather.currentTemp)
        currentLoc.text = currentWeather.cityName
        currentWeatherImg.image = UIImage(named: currentWeather.weatherType)
        currentWeatherDesc.text = currentWeather.weatherType
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        let forecastURL = URL(string: FORECAST_URL)!
        Alamofire.request(forecastURL).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject> {
                if let list = dict["list"] as? [Dictionary<String,AnyObject>] {
                    for obj in list {
                        let forecast = Forecast (weatherDict: obj)
                        self.forecasts.append(forecast)
                        print(obj)
                    }
                }
            }
            completed()
        }
    }
    
}

