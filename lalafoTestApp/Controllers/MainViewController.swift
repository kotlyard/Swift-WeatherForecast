//
//  ViewController.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UITableViewController {

    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainIcon: UIImageView!
    
    @IBAction func refreshWeather(_ sender: UIBarButtonItem) {
        turnOffInterface()
        CLManager.requestLocation()
    }
    
    
    private let CLManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    
    private var weather: CurrentWeather? = nil {
        didSet {
            self.title = APPSettigns.shared.city
            self.sunsetLabel.text = "Sunset: " + self.weather!.sunsetTime
            self.sunriseLabel.text = "Sunrise: " + self.weather!.sunriseTime
            self.visibilityLabel.text = "Visibility: " + self.weather!.visibility
            self.windLabel.text = "Wind: " + self.weather!.windDeg + " " + self.weather!.windSpeed + (APPSettigns.shared.units == "Metric" ? "m/s" : "mi/h")
            self.tmpLabel.text = self.weather!.tmp + (APPSettigns.shared.units == "Metric" ? " C°" : " F°")
            self.descriptionLabel.text = self.weather?.description
            self.mainIcon.image = UIImage(named: (self.weather?.imgCode)!)
        }
    }
    
    private var weatherFor5: WeatherFor5Days? = nil
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        turnOffInterface()
        setUpLocationManager()
    }

    deinit {
        CLManager.delegate = nil
    }
}



// - MARK: LOCATION STUFF
extension MainViewController: CLLocationManagerDelegate {
    private func setUpLocationManager() {
        CLManager.delegate = self
        CLManager.requestWhenInUseAuthorization()
        CLManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        CLManager.requestLocation()
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("start")
        geoCoder.reverseGeocodeLocation(locations.first!) { [weak self] (placemarks, error) in
            print("geocode")
            guard let _ = self else { return }
            if let error = error {
                print(error)
                return
            }
            guard let placemark = placemarks?.first else {
                print("No placemarks")
                return
            }
            if let city = placemark.locality, let code = placemark.isoCountryCode {
                APPSettigns.shared.city = city
                APPSettigns.shared.countryCode = code
                print("network request")
                NetworkManager.shared.getCurrentWeather() { dict in
                    guard let tmp = dict else { print("nil nil nil"); return }
                    self?.weather = CurrentWeather(json: tmp)
                    self!.turnOnInterface()
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        turnOnInterface()
        if self.presentedViewController == nil {
            showAlert(with: "Error getting user location. Turn on location services and restart the Application")
        }
    }
}

extension MainViewController {
    func kek () {
        tableView.cellForRow(at: IndexPath(row: 0, section: 1))?.textLabel!.text = "sas"
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "sas"
    }
}
