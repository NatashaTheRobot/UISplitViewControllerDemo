//
//  SelectColorTableViewController.swift
//  SplitViewControllerDemo
//
//  Created by Natasha Murashev on 10/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

struct Color {
    let displayName: String
    let color: UIColor
}

class SelectColorTableViewController: UITableViewController {

    fileprivate let colorCellIdentifier = "colorCell"
    
    var collapseDetailViewController: Bool  = true
    
    fileprivate let colors = [
        Color(displayName: "Green", color: UIColor.green),
        Color(displayName: "Blue", color: UIColor.blue),
        Color(displayName: "Yellow", color: UIColor.yellow),
        Color(displayName: "Purple", color: UIColor.purple),
        Color(displayName: "Orange", color: UIColor.orange),
        Color(displayName: "Magenta", color: UIColor.magenta),
        Color(displayName: "Brown", color: UIColor.brown),
        Color(displayName: "Cyan", color: UIColor.cyan),
        Color(displayName: "Red", color: UIColor.red)
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // identifier if required, if you have more then one segue
        // it could be set via IB, i did ...
        if segue.identifier == "show_detail_segue_id" {
            
            // colorViewController should never be assigned to nil !!!
            var colorViewController: ColorViewController!
            
            // with help of adaptive segue we can support all devices
            if let colorNavigationController = segue.destination as? UINavigationController {

                // works on devices where UISplitViewController is implemented
                colorViewController = colorNavigationController.topViewController as! ColorViewController
                colorViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                colorViewController.navigationItem.leftItemsSupplementBackButton = true
            } else {

                // works for iPhone on ios7, where UISplitViewController is not implemented
                colorViewController = segue.destination as! ColorViewController
            }
            // this is common part, where one can configure detail view
            // segue provides a new instance of detail view everytime
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
                let color = colors[selectedRowIndexPath.row]
                colorViewController.color = color
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: colorCellIdentifier, for: indexPath) as UITableViewCell        
        let color = colors[indexPath.row]
        cell.textLabel?.text = color.displayName
        
        return cell
    }
    
    // MARK: Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collapseDetailViewController = false
    }

}
