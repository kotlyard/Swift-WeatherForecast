//
//  Extensions.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/25/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func turnOnInterface() {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.view.isUserInteractionEnabled = true
            self.view.layer.opacity = 1
        }
        
    }
    
    func turnOffInterface() {
        
        DispatchQueue.main.async {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.view.isUserInteractionEnabled = false
            self.view.layer.opacity = 0.6
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }
}


extension Date {
    
    func totalDistance(from date: Date, resultIn component: Calendar.Component) -> Int? {
        return Calendar.current.dateComponents([component], from: self, to: date).value(for: component)
    }
    
    func compare(with date: Date, only component: Calendar.Component) -> Int {
        let days1 = Calendar.current.component(component, from: self)
        let days2 = Calendar.current.component(component, from: date)
        return days1 - days2
    }
    
    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        return self.compare(with: date, only: component) == 0
    }
}


extension Notification.Name {
    static let  didChangeData = Notification.Name("didChangeData")
}


extension String {
    
    private func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    /// The same string with first symbol capitalized
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
