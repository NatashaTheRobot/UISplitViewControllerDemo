//
//  ColorViewController.swift
//  SplitViewControllerDemo
//
//  Created by Natasha Murashev on 10/27/14.
//  Copyright (c) 2014 NatashaTheRobot. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    var color = Color(displayName: "White", color: UIColor.whiteColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\(color.displayName) Color"
        view.backgroundColor = color.color
        
        // Configuring the Navigation Item 
        // Add this line of code!
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
    }

}
