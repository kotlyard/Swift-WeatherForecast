//
//  Weather.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import Foundation

struct CurrentWeather {
    
    var sunriseTime  = "Error"
    var sunsetTime   = "Error"
    var tmp          = "Error"
    var visibility   = "Error"
    var windSpeed    = "Error"
    var windDeg      = "Error"
    var description  = "Error"
    var imgCode      = "Error"
    
    
    
    init(json: Dictionary<String, Any>) {
        if let visibility = json["visibility"] as? Int {
            self.visibility = visibility.description + " m"
        } else { self.visibility = "0" }
        if let sys = json["sys"] as? Dictionary<String, Any> {
            if let sunrise = sys["sunrise"] as? Double {
                self.sunriseTime = CurrentWeather.getTime(since1970: sunrise)
            }
            if let sunset = sys["sunset"] as? Double {
                self.sunsetTime = CurrentWeather.getTime(since1970: sunset)
            }
        }

        if let wind = json["wind"] as? Dictionary<String, Double> {
            self.windSpeed = wind["speed"]?.description ?? "0"
            self.windDeg = CurrentWeather.getWindDirection(by:(wind["deg"] ?? 0))
        }
        if let weather = json["weather"] as? Array<Dictionary<String, Any>> {
            self.description = weather.first?["description"] as? String ?? "Error"
            self.imgCode = weather.first?["icon"] as? String ?? "01d"
        }
        if let main = json["main"] as? Dictionary<String, Double> {
            self.tmp = Int(main["temp"] ?? 0).description ?? "Error"
        }
        
        
    
    }
}


extension CurrentWeather {
    static func getTime(since1970: Double) -> String {
        let date = Date(timeIntervalSince1970: since1970)
        let formatter = DateFormatter()
        formatter.timeZone = .current
        formatter.dateFormat = "HH:mm"
        
        return formatter.string(from: date)
    }
    
    static func getWindDirection(by degrees: Double) -> String {
        switch degrees {
        case 0...33.75:
            return "N"
        case 33.75...78.75:
            return "NE"
        case 78.75...123.75:
            return "E"
        case 123.75...168.75:
            return "SE"
        case 168,75...213.75:
            return "SW"
        case 213.75...258.75:
            return "W"
        case 258.75...326.25:
            return "NW"
        default:
            return "N"
        }
    }
}




