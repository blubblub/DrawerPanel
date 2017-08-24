//
//  ViewController.swift
//  drawer
//
//  Created by Alen Kirm on 18. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let drawerApi = AddDrawer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let drawerVC = storyboard?.instantiateViewController(withIdentifier: "DrawViewController") {
            drawerApi.addViewController(drawerVC, toViewController: self, viewBackgroundColor: .lightGray, topOffset: CGPoint(x: 0.0, y: 40.0), middleOffset: CGPoint(x: 0.0, y: (drawerVC.view.frame.size.height) / 2), bottomOffset: CGPoint(x: 0, y: drawerVC.view.frame.size.height - 80.0))
        }
    }

}

extension UIViewController {
    
    func addDrawer(contentView: DrawerView, backgroundColor: UIColor) {
        contentView.backgroundColor = backgroundColor
        contentView.footerView.backgroundColor = backgroundColor
    }
}

