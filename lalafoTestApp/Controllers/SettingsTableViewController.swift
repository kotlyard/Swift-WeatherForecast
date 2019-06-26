//
//  SettingsTableViewController.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/26/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentLang.text = APPSettigns.shared.language
        if APPSettigns.shared.units == "Metric" { segment.selectedSegmentIndex = 0 }
        else { segment.selectedSegmentIndex = 1 }
    }
    
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var currentLang: UILabel!
    
    @IBAction func UnitsSwithced(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            APPSettigns.shared.units = "Metric"
        } else {
            APPSettigns.shared.units = "Imperial"
        }
    }
    

}
