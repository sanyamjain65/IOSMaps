//
//  ViewController.swift
//  IOSMaps
//
//  Created by Sanyam Jain on 20/01/19.
//  Copyright © 2019 Sanyam Jain. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class ViewController: UIViewController {
    @IBOutlet weak var mapView: GMSMapView!
    private let locationManager = CLLocationManager()
    var currentLocationMarker: GMSMarker?

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        mapView.delegate = self
    }
    
    private func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
        }
    }
}

extension ViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let markerr = GMSMarker(position: coordinate)
        markerr.position.latitude = coordinate.latitude
        markerr.position.longitude = coordinate.longitude
        print("hello")
        print(markerr.position.latitude)
        let ULlocation = markerr.position.latitude
        let ULlgocation = markerr.position.longitude
        print(ULlocation)
        print(ULlgocation)
        let geocoder = GMSGeocoder()
        
        // 2
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            let components = URLComponents(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(ULlocation)&lon=\(ULlgocation)&units=metric&appid=39977866234e8867bab8d22015b56728")!
            var urlRequest = URLRequest(url: components.url!)
            urlRequest.httpMethod = "GET"
            let config = URLSessionConfiguration.default
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: urlRequest as URLRequest, completionHandler: { data, response, error in
                guard error == nil else {
                    return
                }
                if data == nil {
                    return
                }
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] {
                        print(json)
                        
                        DispatchQueue.main.async {
                            let view: WeatherDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
                            
                            self.navigationController?.pushViewController(view, animated: true)
                            view.weatherJson = json
                            view.add = lines.joined(separator: "\n")
                        }
                        
                    }
                } catch let error {
                    
                }
            })
            task.resume()
        }
        
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        
        locationManager.stopUpdatingLocation()
        currentLocationMarker = GMSMarker(position: location.coordinate)
        currentLocationMarker?.title = "current Location"
        currentLocationMarker?.map = mapView
        currentLocationMarker?.rotation = locationManager.location?.course ?? 0
    }
}
