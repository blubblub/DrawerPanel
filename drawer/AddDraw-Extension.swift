//
//  AddDraw-Extension.swift
//  drawer
//
//  Created by Alen Kirm on 25. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import Foundation

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
