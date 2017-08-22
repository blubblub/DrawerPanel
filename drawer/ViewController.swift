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
        
        if let drawerVC = storyboard?.instantiateViewController(withIdentifier: "DrawViewController") as? UIViewController {
            drawerApi.addViewController(drawerVC, toViewController: self)
        }        
    }

}

