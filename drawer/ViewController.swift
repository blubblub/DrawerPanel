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
        
        if let drawableViewController = storyboard?.instantiateViewController(withIdentifier: "DrawViewController") {
            drawableViewController.view.frame = CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height)
            self.addChildViewController(drawableViewController)
            self.view.addSubview(drawableViewController.view)
        }
    }

}

