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

class SelectColorTableViewController: UITableViewController, UISplitViewControllerDelegate {

    private let colorCellIdentifier = "colorCell"
    
    private var collapseDetailViewController = true
    
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
        
        splitViewController?.delegate = self
                
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let colorNavigationController = segue.destinationViewController as? UINavigationController {
            if let colorViewController = colorNavigationController.topViewController as? ColorViewController {
                if let selectedRowIndexPath = tableView.indexPathForSelectedRow() {
                    let color = colors[selectedRowIndexPath.row]
                    colorViewController.color = color
                }

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
        cell.textLabel.text = color.displayName
        
        return cell
    }
    
    // MARK: Table View Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        collapseDetailViewController = false
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController!, ontoPrimaryViewController primaryViewController: UIViewController!) -> Bool {
        return collapseDetailViewController
    }
    
}
