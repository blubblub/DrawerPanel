//
//  DrawerView.swift
//  drawer
//
//  Created by Alen Kirm on 22. 08. 17.
//  Copyright © 2017 Alen Kirm. All rights reserved.
//

import UIKit

class DrawerView: UIView {
    
    //
    //// View's initial coordinates and size, which we'll be using for handling view position (reseting ...)
    //
    var viewOrigin: CGRect!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    private func setupView() {
        self.layer.cornerRadius = 10
        
        // add origin
        viewOrigin = CGRect(x: 0, y: self.frame.size.height - 80, width: self.frame.size.width, height: self.frame.size.height)
        
        // add gesture recognizers to this view
        addTapGestureRecognizer(view: self)
        addPanGestureRecognizer(view: self)
    }
    
    //
    //// Adding pan gesture recognizer with handlePan func implemented below
    //
    private func addPanGestureRecognizer(view: UIView) {
        let pan = UIPanGestureRecognizer(target: view, action: #selector(self.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    //
    //// Adding tap gesture recognizer with handleTap func implemented below
    //
    private func addTapGestureRecognizer(view: UIView) {
        let tap = UITapGestureRecognizer(target: view, action: #selector(self.handleTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    //
    //// HandleTap function
    //
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        
        //
        //// Getting sender .view property, else exit function (nothing to do without uiview.view)
        //
        guard let senderView = sender.view else { return }
        
        var viewExtended: Bool {
            return senderView.frame == CGRect(x: 0, y: 40 , width: senderView.frame.size.width, height: senderView.frame.size.height)
        }
        
        if !viewExtended {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                senderView.frame = CGRect(x: 0, y: 40 , width: senderView.frame.size.width, height: senderView.frame.size.height)
            }
            animator.startAnimation()
        } else {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
                senderView.frame = self.viewOrigin
            }
            animator.startAnimation()
        }
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        
        let panSender = sender
        
        guard let senderView = sender.view else { return }
        
        switch panSender.state {
        case .began, .changed:
            if senderView.frame.origin.y >= 40 {
                moveViewWithPan(view: senderView, sender: panSender)
            }
            print("view coordinates: \(senderView.frame.origin.y)")
        case .ended:
            handleViewPosition(withCurrentCoordinates: senderView.frame, view: self, sender: panSender)
        default:
            break
        }
    }
    
    private func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        view.center = CGPoint(x: self.center.x, y: self.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self)
    }
    
    private func handleViewPosition(withCurrentCoordinates position: CGRect, view: UIView, sender: UIPanGestureRecognizer) {
        let thirdOfViewSize = (view.frame.size.height / 3)
        
        let viewPosition = view.frame.origin.y
        
        if viewPosition >= (thirdOfViewSize * 2)  {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                view.frame = self.viewOrigin
            }
            animator.startAnimation()
        } else if viewPosition > thirdOfViewSize {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                view.frame.origin.y = thirdOfViewSize
            }
            animator.startAnimation()
        } else if viewPosition < thirdOfViewSize {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
                view.frame = CGRect(x: 0, y: 40 , width: view.frame.size.width, height: view.frame.size.height)
            }
            animator.startAnimation()
        }
        
        print(position.size.height, position.size.width)
        print("view position: \(viewPosition)")
        print("third of vc size: \(thirdOfViewSize)")
    }

}
