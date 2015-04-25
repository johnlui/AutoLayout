//
//  ViewController.swift
//  AutoLayout
//
//  Created by JohnLui on 15/2/24.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainViewTopSpaceLayoutConstraintValue: CGFloat!
    var mainViewOriginY: CGFloat!
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topLayoutConstraintOfMainView: NSLayoutConstraint!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture.addTarget(self, action: Selector("pan:"))
        mainViewTopSpaceLayoutConstraintValue = topLayoutConstraintOfMainView.constant
        mainViewOriginY = mainView.frame.origin.y
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        if panGesture.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                recongnizer.view?.frame.origin.y = self.mainViewOriginY
                }, completion: { (success) -> Void in
                    if success {
                        self.topLayoutConstraintOfMainView.constant = self.mainViewTopSpaceLayoutConstraintValue
                    }
            })
            return
        }
        let y = panGesture.translationInView(self.view).y
        topLayoutConstraintOfMainView.constant = mainViewTopSpaceLayoutConstraintValue + y
    }

}

