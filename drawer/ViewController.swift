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
        
        
        guard let drawerVC = storyboard?.instantiateViewController(withIdentifier: "DrawViewController") else { return }
        
        let drawer = self.addDrawer(viewController: drawerVC)
    }

}

extension UIViewController {
    
    func addDrawer(viewController: UIViewController) -> DrawerView {
        
        let drawerView = DrawerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height))
        drawerView.backColor = UIColor.yellow
        drawerView.topOffset = 40
        drawerView.middleOffset = drawerView.frame.height / 2
        drawerView.innerView = viewController.view
        
        self.addChildViewController(viewController)
        self.view.addSubview(drawerView)
        
        return drawerView
    }
    
    func addDrawer(contentView: UIView) {
        self.view.addSubview(contentView)
    }
}

