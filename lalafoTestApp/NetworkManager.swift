//
//  APIController.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkManager {
    static  let shared = NetworkManager()
    private init() {}
    
    
    private let apiKey = "e8c96b522cbcc77345dc1229daa70bc9"
    let urlFor5 = "https://api.openweathermap.org/data/2.5/forecast?"
    let urlCurrent = "https://api.openweathermap.org/data/2.5/weather?"
   
    
    
    func getCurrentWeather(completion: @escaping (([String:Any]?) -> Void)) {
        let headers: HTTPHeaders = [
            "appid": self.apiKey,
            "q": APPSettigns.shared.city + "," + APPSettigns.shared.countryCode,
            "units": APPSettigns.shared.units.lowercased(),
            "lang": APPSettigns.shared.lang 
        ]
        
        guard let url = URL(string: urlCurrent) else { fatalError("error creatint link with name: \(self.urlCurrent)") }
        Alamofire.request(url, method: .get, parameters: headers).validate().responseJSON { response in
            if response.error == nil {
                do {
                    let res = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? [String: Any]
                    completion(res)
                } catch let error {
                    completion(nil)
                    print(error.localizedDescription)
                }
                
            } else {
                print(response.error?.localizedDescription)
            }
        }
    }
    
    func getWeatherFor5Days(completion: @escaping (([String:Any]?) -> Void)) {
        
        let headers: HTTPHeaders = [
            "appid": self.apiKey,
            "q": APPSettigns.shared.city,
            "units": APPSettigns.shared.units.lowercased(),
            "lang": APPSettigns.shared.lang
        ]
        
        guard let url = URL(string: urlFor5) else { fatalError("error creatint link with name: \(self.urlFor5)") }
        
        Alamofire.request(url, method: .get, parameters: headers).validate().responseJSON { response in
            if response.error == nil {
                do {
                    let res = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? [String: Any]
//                    print(res)
                    completion(res)
                } catch let error {
                    completion(nil)
                    print(error.localizedDescription)
                }
            } else {
                print(response.error?.localizedDescription)
            }
        }
    }
    
}
