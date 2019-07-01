//
//  LanguageTableViewController.swift
//  lalafoTestApp
//
//  Created by Denis KOTLYAR on 6/26/19.
//  Copyright © 2019 Denis KOTLYAR. All rights reserved.
//

import UIKit

class LanguageTableViewController: UITableViewController {

    let languages = Array(APPSettigns.shared.langDict.keys)
    
    var selected =  IndexPath()

}


// - MARK: TableView STUFF
extension LanguageTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  APPSettigns.shared.langDict.keys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = languages[indexPath.row]
        if cell.textLabel?.text == APPSettigns.shared.language {
            cell.accessoryType = .checkmark
            self.selected = indexPath
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selected == indexPath { return }
        tableView.cellForRow(at: selected)?.accessoryType = .none
        selected = indexPath
        tableView.cellForRow(at: selected)?.accessoryType = .checkmark
        APPSettigns.shared.language = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "Error"
        performSegue(withIdentifier: "backSegue", sender: nil)
    }
}
