//
//  APPSettings.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import Foundation

final class APPSettigns {
    
    static let shared = APPSettigns()
    
    private init() {}
    
    
    var language = "English" {
        didSet {
            self.lang = self.langDict[self.language] ?? "en"
        }
    }
   
    var city = "Kiev"
    var countryCode = "UKR"
    var units = "Metric"
  
        
    var lang = "en"
    let langDict = [
        "English"   :   "en",
        "Russian"   :   "ru",
        "Chinese"   :   "zh_cn",
        "Arabic"    :   "ar",
        "French"    :   "fr",
        "German"    :   "de",
        "Italian"   :   "it",
        "Japanese"  :   "ja",
        "Ukrainian" :   "ua",
        "Polish"    :   "pl"
    ]
}
