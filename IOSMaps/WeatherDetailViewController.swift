//
//  WeatherDeatailsViewController.swift
//  IOSMaps
//
//  Created by Sanyam Jain on 03/02/19.
//  Copyright © 2019 Sanyam Jain. All rights reserved.
//

import Foundation
import UIKit

class WeatherDetailViewController: UIViewController {
    var weatherJson: [String: Any]! = nil
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    override func viewDidLoad() {
        print(weatherJson)
        let mainJson = weatherJson["main"] as! [String: Any]
        guard let temperature = mainJson["temp_max"] as! NSNumber else {
            return
        }
        guard let humidity = mainJson["temp_min"] as! Int else {
            return
        }
        self.temperature.text = String(temperature)
        self.humidity.text = String(humidity)
        
    }
    
}
