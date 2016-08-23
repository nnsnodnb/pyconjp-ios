//
//  MoreViewController.swift
//  PyConJP2016
//
//  Created by Yutaro Muta on 3/7/16.
//  Copyright © 2016 PyCon JP. All rights reserved.
//

import UIKit
import SafariServices

class MoreViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    private func aboutSection(row: Int) {
        let identifier: String = {
            switch row {
            case 0:
                return "WhatPyConJPViewController"
            case 1:
                return "CodeOfConductViewController"
            case 2:
                return "SummaryViewController"
            default:
                return ""
            }
        }()
        if let viewController = self.storyboard?.instantiateViewControllerWithIdentifier(identifier) {
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func mapSection(row: Int) {
        switch row {
        case 0:
            let mapListViewController = MapListViewController.build()
            self.navigationController?.pushViewController(mapListViewController, animated: true)
        case 1:
            let mapViewController = MapViewController.build(MapViewController.Venue.Microsoft)
            self.navigationController?.pushViewController(mapViewController, animated: true)
        default:
            break
        }
    }
    
    private func applicationSection(row: Int) {
        switch row {
        case 0:
            let safariViewController = SFSafariViewController(URL: NSURL(string: "https://github.com/pyconjp/pyconjp-ios")!)
            self.presentViewController(safariViewController, animated: true, completion: nil)
        case 1:
            let libraryViewController = LibraryListViewController.build()
            self.navigationController?.pushViewController(libraryViewController, animated: true)
        case 2:
            let licenseViewController = self.storyboard?.instantiateViewControllerWithIdentifier("LicenseViewController")
            self.navigationController?.pushViewController(licenseViewController!, animated: true)
        default:
            break
        }
    }
    
    // MARK: - Table View Controller Delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch TableViewSection(rawValue: indexPath.section) ?? .About {
        case .About:
            aboutSection(indexPath.row)
        case .Map:
            mapSection(indexPath.row)
        case .Application:
            applicationSection(indexPath.row)
        }
    }
    
    private enum TableViewSection: Int {
        case About =  0
        case Map = 1
        case Application = 2
    }
    
}
