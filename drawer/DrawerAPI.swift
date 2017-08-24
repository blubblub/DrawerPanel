//
//  DrawerAPI.swift
//  drawer
//
//  Created by Alen Kirm on 18. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import Foundation
import UIKit

class AddDrawer {
    
    func addViewController(_ baseViewController: UIViewController, toViewController parentVC: UIViewController) {
        
        baseViewController.view.frame = CGRect(x: 0, y: parentVC.view.frame.size.height - 80, width: parentVC.view.frame.size.width, height: parentVC.view.frame.size.height)
        
        parentVC.addChildViewController(baseViewController)
        parentVC.view.addSubview(baseViewController.view)
    }
    
}
