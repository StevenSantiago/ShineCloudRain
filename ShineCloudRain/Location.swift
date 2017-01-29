//
//  Location.swift
//  ShineCloudRain
//
//  Created by Steven Santiago on 1/28/17.
//  Copyright © 2017 Steven Santiago. All rights reserved.
//Singleton class

import Foundation
import CoreLocation

class Location {
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
