//
//  ViewController.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var tmpLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mainIcon: UIImageView!
    
    
    private let CLManager = CLLocationManager()
    private let geoCoder = CLGeocoder()
    
    private var weather: Weather? = nil {
        didSet {
            self.title = APPSettigns.shared.city
            self.sunsetLabel.text = APPSettigns.shared.languagePack["Sunset"]! + ": " + self.weather!.sunsetTime
            self.sunriseLabel.text = APPSettigns.shared.languagePack["Sunrise"]! + ": " + self.weather!.sunriseTime
            self.visibilityLabel.text = APPSettigns.shared.languagePack["Visibility"]! + ": " + self.weather!.visibility
            self.windLabel.text = APPSettigns.shared.languagePack["Wind"]! + ": " + self.weather!.windDeg + " " + self.weather!.windSpeed + (APPSettigns.shared.units == "Metric" ? "m/s" : "mi/h")
            self.tmpLabel.text = self.weather!.tmp + (APPSettigns.shared.units == "Metric" ? " °C" : " °F")
            self.descriptionLabel.text = APPSettigns.shared.lang == "ind" ?  "स्पष्ट है" : self.weather?.description
            self.mainIcon.image = UIImage(named: (self.weather?.imgCode)!)
        }
    }
    
    private var weatherFor5: WeatherFor5Days? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpLocationManager()
        NotificationCenter.default.addObserver(self, selector: #selector(needToRefreshData), name: .didChangeData, object: nil)
        needToRefreshData()
    }

    @objc func needToRefreshData() {
        turnOffInterface()
        CLManager.requestLocation()
        APPSettigns.shared.saveToUserDefaults()
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
        geoCoder.reverseGeocodeLocation(locations.first!) { [weak self] (placemarks, error) in
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
                    self?.weather = Weather(json: tmp)
                    self!.turnOnInterface()
                }
                NetworkManager.shared.getWeatherFor5Days() { dict in
                    guard let tmp = dict else { print("nil nil nil"); return }
                    self?.weatherFor5 = WeatherFor5Days(json: tmp)
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



// TABLE
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherFor5?.days.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherFor5?.days[section].count ?? 1
    }
    
 
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if weatherFor5?.days == nil { return nil }
        
        let f = DateFormatter()
        f.locale = Locale.init(identifier: "en")
        let tmp = f.weekdaySymbols[Calendar.current.component(.weekday, from: (weatherFor5?.days[section].first!.date) ?? Date()) - 1]
        return APPSettigns.shared.languagePack[tmp] ?? tmp
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if weatherFor5 == nil { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell")
        if let rightDay = weatherFor5?.days[indexPath.section][indexPath.row] {
            cell?.textLabel?.text = rightDay.time
            
            var description = rightDay.description
            if  APPSettigns.shared.language == "Hindi" {
                description = LanguagesPack.Hindi[description] ?? "स्पष्ट है"
            }
            let tmp = rightDay.tmp
            cell?.detailTextLabel?.text =  description +  ", " +  tmp + (APPSettigns.shared.units == "Metric" ? " °C" : " °F")
            cell?.imageView?.image = UIImage(named: rightDay.imgCode)
            return cell!
        }
        return UITableViewCell()
    }
    
}
