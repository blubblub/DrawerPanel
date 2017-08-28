//
//  ViewController.swift
//  drawer
//
//  Created by Alen Kirm on 18. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var drawer : DrawerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let drawerVC = storyboard?.instantiateViewController(withIdentifier: "DrawViewController") else { return }

        let drawer = self.addDrawer(viewController: drawerVC)
        drawer.topOffset = 150
        drawer.innerView?.backgroundColor = UIColor.green
        
        
//        let view = UIView()
//        view.frame = CGRect(origin: self.view.center, size: CGSize(width: 250, height: 300))
//        view.backgroundColor = .blue
//
//        drawer = addDrawer(contentView: view)
        
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        drawer.frame = CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height)
//    }

}

extension UIViewController {
    
    func addDrawer(viewController: UIViewController) -> DrawerView {
        
        let drawerView = DrawerView(frame: CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height))
        drawerView.innerView = viewController.view
        
        self.addChildViewController(viewController)
        self.view.addSubview(drawerView)
        
        return drawerView
    }
    
    func addDrawer(contentView: UIView) -> DrawerView {
        let drawer = DrawerView(frame: contentView.frame)
        drawer.innerView?.backgroundColor = UIColor.red
        drawer.innerView = contentView
        
        self.view.addSubview(drawer)
        
        return drawer
    }
}


