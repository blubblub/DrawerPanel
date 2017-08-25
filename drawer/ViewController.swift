//
//  ViewController.swift
//  drawer
//
//  Created by Alen Kirm on 18. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let drawerView = DrawerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height), backgroundColor: .blue)
//        drawerView.topOffset = 100
//        drawerView.middleOffset = 300
//        addDrawer(contentView: drawerView)
        
        
        addDrawer(to: self, withBackgroundColor: .blue)
    }

}

extension UIViewController {
    
    func addDrawer(to viewController: UIViewController, withBackgroundColor backColor: UIColor) {
        
        guard let drawerVC = storyboard?.instantiateViewController(withIdentifier: "DrawViewController") else { return }
        
        let drawerView = DrawerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height), backgroundColor: backColor)
        drawerView.topOffset = 40
        drawerView.middleOffset = drawerView.frame.height / 2
        
        drawerVC.view = drawerView
        viewController.addChildViewController(drawerVC)
        viewController.view.addSubview(drawerView)
    }
    
    func addDrawer(contentView: UIView) {
        self.view.addSubview(contentView)
    }
}

