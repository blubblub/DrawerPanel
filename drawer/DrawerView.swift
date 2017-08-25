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
    private var footerView: UIView!
    var topOffset: CGFloat = 40
    var middleOffset: CGFloat = 200
    var bottomOffset: CGFloat = 80
    var openToTopOnTap: Bool = true
    var backColor: UIColor = .lightGray
    
    var innerView : UIView? {
        didSet {
            guard let innerView = innerView else {
                return
            }
            
            if innerView.superview !== self {
                innerView.backgroundColor = backColor
                footerView.backgroundColor = backColor
                innerView.layer.cornerRadius = 10
                addSubview(innerView)
                setNeedsLayout()
            }
        }
    }
    
    private var computedMiddleOffset: CGFloat {
        return self.frame.height - middleOffset - topOffset
    }
    
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
        
        if let innerView = innerView {
            innerView.frame = self.bounds
        }
        
        self.footerView.frame = CGRect(origin: CGPoint(x: 0.0, y: self.frame.size.height - 10), size: CGSize(width: self.frame.size.width, height: 200.0))
    }
    
    private func setupView() {
        
        // add gesture recognizers to this view
        addTapGestureRecognizer(view: self)
        addPanGestureRecognizer(view: self)
        
        // add subview
        self.footerView = UIView()
        
        footerView.backgroundColor = innerView?.backgroundColor
        
        self.addSubview(footerView)
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
        if openToTopOnTap {
            guard let senderView = sender.view else { return }
            var viewExtended: Bool {
                return senderView.frame == CGRect(origin: CGPoint(x: 0, y: topOffset), size: CGSize(width: senderView.frame.size.width, height: senderView.frame.size.height))
            }
            
            if !viewExtended {
                let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                    senderView.frame = CGRect(origin: CGPoint(x: 0, y: self.topOffset), size: CGSize(width: senderView.frame.size.width, height: senderView.frame.size.height))
                }
                animator.startAnimation()
            } else {
                let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
                    senderView.frame = CGRect(x: 0, y: senderView.frame.size.height - 80, width: senderView.frame.size.width, height: senderView.frame.size.height)
                }
                animator.startAnimation()
            }
        }
        
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        
        guard let senderView = sender.view else { return }
        
        switch sender.state {
        case .began, .changed:
            if senderView.frame.origin.y >= topOffset {
                moveViewWithPan(view: senderView, sender: sender)
            }
        case .ended:
            handleViewPosition(withCurrentCoordinates: senderView.frame, view: self, sender: sender)
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
        
        let viewHeight = view.frame.height
        let viewPosition = view.frame.origin.y
        
        if viewPosition >= viewHeight - bottomOffset {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeIn) {
                view.frame = CGRect(x: 0, y: view.frame.size.height - self.bottomOffset, width: view.frame.size.width, height: view.frame.size.height)
            }
            animator.startAnimation()
        } else if viewPosition > computedMiddleOffset {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                view.frame = CGRect(origin: CGPoint(x: 0, y: self.computedMiddleOffset), size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
            }
            animator.startAnimation()
        } else {
            let animator = UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
                view.frame = CGRect(origin: CGPoint(x: 0, y: self.topOffset), size: CGSize(width: view.frame.size.width, height: view.frame.size.height))
            }
            animator.startAnimation()
        }
    }
    
}
