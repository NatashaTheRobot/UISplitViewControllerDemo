//
//  SplitViewSupport.swift
//  MasterDetailDemo
//
//  Created by Ivo Vacek on 28/01/15.
//  Copyright (c) 2015 Ivo Vacek. All rights reserved.
//

import UIKit

// MARK: - iPad ios7support

extension UISplitViewController: UISplitViewControllerDelegate {
    
    struct ios7Support {
        static var modeButtonItem: UIBarButtonItem?
    }
    
    var backBarButtonItem: UIBarButtonItem? {
        get {
            if responds(to: #selector(getter: UISplitViewController.displayModeButtonItem)) == true {
                let button: UIBarButtonItem = displayModeButtonItem
                return button
            } else {
                return ios7Support.modeButtonItem
            }
        }
        set {
            ios7Support.modeButtonItem = newValue
        }
    }
    
    // simple trick, without swizzling :-)
    
    func displayModeButtonItem(_: Bool = true)->UIBarButtonItem? {
        return backBarButtonItem
    }
    
    public func splitViewController(_ svc: UISplitViewController, willHide aViewController: UIViewController, with barButtonItem: UIBarButtonItem, for pc: UIPopoverController) {
        if (!svc.responds(to: #selector(getter: UISplitViewController.displayModeButtonItem))) {
            if let detailView = svc.viewControllers[svc.viewControllers.count-1] as? UINavigationController {
                svc.backBarButtonItem = barButtonItem
                detailView.topViewController?.navigationItem.leftBarButtonItem = barButtonItem
            }
        }
    }
    
    
    public func splitViewController(_ svc: UISplitViewController, willShow aViewController: UIViewController, invalidating barButtonItem: UIBarButtonItem) {
        if (!svc.responds(to: #selector(getter: UISplitViewController.displayModeButtonItem))) {
            if let detailView = svc.viewControllers[svc.viewControllers.count-1] as? UINavigationController {
                svc.backBarButtonItem = nil
                detailView.topViewController?.navigationItem.leftBarButtonItem = nil
            }
        }
    }
    
    // MARK: - user defined imlementation of UISplitViewControllerDelegate
    
    public func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let navController = primaryViewController as? UINavigationController {
            if let controller = navController.topViewController as? SelectColorTableViewController {
                return controller.collapseDetailViewController
            }
        }
        return true
    }
 
}
