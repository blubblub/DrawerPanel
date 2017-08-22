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
        
        baseViewController.view.layer.cornerRadius = 10
        
        let footerVC = UIView()
        footerVC.backgroundColor = #colorLiteral(red: 0.7233663201, green: 0.7233663201, blue: 0.7233663201, alpha: 1)
        footerVC.frame = CGRect(origin: CGPoint(x: baseViewController.view.frame.origin.x, y: baseViewController.view.frame.origin.y), size: CGSize(width: baseViewController.view.frame.size.width, height: baseViewController.view.frame.size.height))
        
        baseViewController.view.addSubview(footerVC)
        
        parentVC.addChildViewController(baseViewController)
        parentVC.view.addSubview(baseViewController.view)
    }
    
}
