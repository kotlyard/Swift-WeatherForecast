//
//  5DaysWeather.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import Foundation

struct WeatherFor5Days  {
    
    var days: [[Weather]] = [[], [], [], [], [], []]

    
    init(json: Dictionary<String, Any>) {
        if let list = json["list"] as? Array<Dictionary<String, Any>> {
            var forcast = [Weather]()
            for elem in list {
                forcast.append(Weather(json: elem))
            }
            sortWeatherByDays(with: forcast)
        }
    }
    
    mutating func sortWeatherByDays(with forcast: [Weather]) {
        var i = 0
        guard var prevDate = forcast.first?.date else { fatalError("Error extracting date from forcast") }
        for elem in forcast {
            if !elem.date.hasSame(Calendar.Component.day, as: prevDate) {
                i += 1
                prevDate = elem.date
            }
            days[i].append(elem)
        }
        print(days)
    }
}
