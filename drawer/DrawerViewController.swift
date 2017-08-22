//
//  DrawerViewController.swift
//  drawer
//
//  Created by Alen Kirm on 18. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import UIKit

class DrawerViewController: UIViewController {
    
    // originial viewcontroller position
    var thisVCOrigin: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.cornerRadius = 10
        addGestureRecognizer(view: self.view)
        addTapGestureRecognizer(view: self.view)
        thisVCOrigin = CGRect(x: 0, y: self.view.frame.size.height - 80, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        // optional, bring tofront
        self.view.superview?.bringSubview(toFront: self.view)
    }
    
    func addGestureRecognizer(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(DrawerViewController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    func addTapGestureRecognizer(view: UIView) {
        let tap = UITapGestureRecognizer(target: self, action: #selector(DrawerViewController.handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer) {
        let viewControllerView = sender.view!
        
        var vcOpened: Bool {
            return viewControllerView.frame == CGRect(x: 0, y: 40 , width: self.view.frame.size.width, height: self.view.frame.size.height)
        }
        
        if !vcOpened {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                viewControllerView.frame = CGRect(x: 0, y: 40 , width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
            animator.startAnimation()
        } else {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
                viewControllerView.frame = self.thisVCOrigin
            }
            animator.startAnimation()
        }
        
    }
    
    @objc func handlePan(sender: UIPanGestureRecognizer) {
        let viewControllerView = sender.view!
        let senderCoordinates = viewControllerView.frame
        
        switch sender.state {
        case .began, .changed:
            if senderCoordinates.origin.y >= 40 {
                moveViewWithPan(view: viewControllerView, sender: sender)
            }
            print("view coordinates: \(senderCoordinates.origin.y)")
        case .ended:
            handleViewPosition(withCurrentCoordinates: senderCoordinates, view: viewControllerView, sender: sender)
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        view.center = CGPoint(x: self.view.center.x, y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    func handleViewPosition(withCurrentCoordinates position: CGRect, view: UIView, sender: UIPanGestureRecognizer) {
        let thirdOfViewControllerSize = (view.frame.size.height / 3)
        
        let viewSize = self.view.frame.size
        let viewPosition = self.view.frame.origin.y
        
        // refactor later if pos :)
        
        if viewPosition >= (thirdOfViewControllerSize * 2)  {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                view.frame = self.thisVCOrigin
            }
            animator.startAnimation()
//            return
        } else if viewPosition > thirdOfViewControllerSize {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                view.frame.origin.y = thirdOfViewControllerSize
            }
            animator.startAnimation()
        } else if viewPosition < thirdOfViewControllerSize {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                view.frame = CGRect(x: 0, y: 40 , width: self.view.frame.size.width, height: self.view.frame.size.height)
            }
            animator.startAnimation()
        }
        
        print(position.size.height, position.size.width)
        print("view position: \(viewPosition)")
        print("third of vc size: \(thirdOfViewControllerSize)")
    }
}
