//
//  ViewController.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/24/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentLoc: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherDesc: UILabel!
    @IBOutlet weak var tabelView: UITableView!
    
    private let numberOfCells = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tabelView.delegate = self
        tabelView.dataSource = self
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

}

