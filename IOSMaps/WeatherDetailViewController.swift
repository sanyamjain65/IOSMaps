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
    var add: String = ""
    
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var humidity: UILabel!
    override func viewDidLoad() {
        print(weatherJson)
        
        let mainJson = weatherJson["main"] as! [String: Any]
        let temperature = mainJson["temp"]
        if mainJson["temp"] is String {
            self.temperature.text = mainJson["temp"] as? String ?? ""
        } else if mainJson["temp"] is NSNumber  {
            let temp: NSNumber = mainJson["temp"] as! NSNumber
            self.temperature.text = temp.stringValue
        } else {
            let temp: Int = mainJson["temp"] as! Int
            self.temperature.text = String(temp)
        }
        if mainJson["humidity"] is String {
            self.humidity.text = mainJson["humidity"] as? String ?? ""
        } else if mainJson["humidity"] is NSNumber  {
            let humidity: NSNumber = mainJson["humidity"] as! NSNumber
            self.humidity.text = humidity.stringValue
        } else {
            let humidity: Int = mainJson["humidity"] as! Int
            self.humidity.text = String(humidity)
        }
        if mainJson["pressure"] is String {
            self.pressure.text = mainJson["pressure"] as? String ?? ""
        } else if mainJson["pressure"] is NSNumber  {
            let pressure: NSNumber = mainJson["pressure"] as! NSNumber
            self.pressure.text = pressure.stringValue
        } else {
            let pressure: Int = mainJson["pressure"] as! Int
            self.pressure.text = String(pressure)
        }
        self.address.text = add
        
    }
    
}
