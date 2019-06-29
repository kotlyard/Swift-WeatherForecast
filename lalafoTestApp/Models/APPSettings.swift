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
    let defaults = UserDefaults.standard
    private init() {}
    
    
    var language = "English" {
        didSet {
            self.lang = self.langDict[self.language] ?? "en"
            switch self.lang {
            case "ru":
                self.languagePack = LanguagesPack.Russian
            case "de":
                self.languagePack = LanguagesPack.German
            case "it":
                self.languagePack = LanguagesPack.Italian
            case "ja":
                self.languagePack = LanguagesPack.Japanese
            case "ind":
                self.languagePack = LanguagesPack.Hindi
            default:
                self.languagePack = LanguagesPack.English
            }
            NotificationCenter.default.post(name: .didChangeData, object: nil)
        }
    }
   
    var city = "Kiev"
    var countryCode = "UKR"
    var units = "Metric" {
        didSet {
            NotificationCenter.default.post(name: .didChangeData, object: nil)
        }
    }
    
    
    var languagePack = LanguagesPack.English
    
    var lang = "en"
    let langDict = [
        "English"   :   "en",
        "Russian"   :   "ru",
        "German"    :   "de",
        "Italian"   :   "it",
        "Hindi"     :   "ind",
        "Japanese"  :   "ja"
    ]
    
    internal func saveToUserDefaults() {
        defaults.set(self.language, forKey: "lalafoLanguage")
        defaults.set(self.units, forKey: "lalafoMetrics")
    }
    
    internal func loadFromUserDefaults() {
        self.language = defaults.string(forKey: "lalafoLanguage") ?? "English"
        self.units = defaults.string(forKey: "lalafoMetrics") ?? "Metric"
    }
} 
