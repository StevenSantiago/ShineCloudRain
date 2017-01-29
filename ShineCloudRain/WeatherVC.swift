//
//  ViewController.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/24/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentLoc: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherDesc: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var forecast : Forecast!
    
    
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()

        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()
    }
    
    func locationAuthStatus() { // will have pop up window appear to request location usage from user
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location // save location if authorized
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.downloadForecastData {
                    self.updateMainUI()
                }
                
            }
        } else { // if not request authorization
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "DataWeather", for: indexPath) as? WeatherCell{
            let forecast = forecasts[indexPath.row]
            cell.configureCell(forecast: forecast)
            return cell
        } else {
            return WeatherCell()
        }
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
                    self.forecasts.remove(at: 0) // remove todays date from cell view
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
}

