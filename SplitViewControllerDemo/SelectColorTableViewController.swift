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

    private let colorCellIdentifier = "colorCell"
    
    var collapseDetailViewController: Bool  = true
    
    private let colors = [
        Color(displayName: "Green", color: UIColor.greenColor()),
        Color(displayName: "Blue", color: UIColor.blueColor()),
        Color(displayName: "Yellow", color: UIColor.yellowColor()),
        Color(displayName: "Purple", color: UIColor.purpleColor()),
        Color(displayName: "Orange", color: UIColor.orangeColor()),
        Color(displayName: "Magenta", color: UIColor.magentaColor()),
        Color(displayName: "Brown", color: UIColor.brownColor()),
        Color(displayName: "Cyan", color: UIColor.cyanColor()),
        Color(displayName: "Red", color: UIColor.redColor())
    ]
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // identifier if required, if you have more then one segue
        // it could be set via IB, i did ...
        if segue.identifier == "show_detail_segue_id" {
            
            // colorViewController should never be assigned to nil !!!
            var colorViewController: ColorViewController!
            
            // with help of adaptive segue we can support all devices
            if let colorNavigationController = segue.destinationViewController as? UINavigationController {

                // works on devices where UISplitViewController is implemented
                colorViewController = colorNavigationController.topViewController as ColorViewController
                colorViewController.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                colorViewController.navigationItem.leftItemsSupplementBackButton = true
            } else {

                // works for iPhone on ios7, where UISplitViewController is not implemented
                colorViewController = segue.destinationViewController as ColorViewController
            }
            // this is common part, where one can configure detail view
            // segue provides a new instance of detail view everytime
            if let selectedRowIndexPath = tableView.indexPathForSelectedRow() {
                let color = colors[selectedRowIndexPath.row]
                colorViewController.color = color
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(colorCellIdentifier) as UITableViewCell
        
        let color = colors[indexPath.row]
        cell.textLabel?.text = color.displayName
        
        return cell
    }
    
    // MARK: Table View Delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        collapseDetailViewController = false
    }

}
