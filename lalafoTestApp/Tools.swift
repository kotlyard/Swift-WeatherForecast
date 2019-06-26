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
}


extension MainViewController {
    func turnOnInterface() {
        DispatchQueue.main.async {
//            self.mainSpinner.stopAnimating()
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.view.isUserInteractionEnabled = true
            self.view.layer.opacity = 1
        }
        
    }
    
    func turnOffInterface() {
        DispatchQueue.main.async {
//            self.mainSpinner.startAnimating()
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.view.isUserInteractionEnabled = false
            self.view.layer.opacity = 0.6
        }
    }
}
