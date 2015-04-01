//
//  ViewController.swift
//  AutoLayout
//
//  Created by JohnLui on 15/2/24.
//  Copyright (c) 2015年 Miao Tec Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var middleViewTopSpaceLayoutConstant: CGFloat!
    var middleViewOriginY: CGFloat!
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var middleViewTopSpaceLayout: NSLayoutConstraint!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture.addTarget(self, action: Selector("pan"))
        middleViewTopSpaceLayoutConstant = middleViewTopSpaceLayout.constant
        middleViewOriginY = middleView.frame.origin.y
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pan() {
        if panGesture.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.middleView.frame.origin.y = self.middleViewOriginY
                }, completion: { (success) -> Void in
                    if success {
                        self.middleViewTopSpaceLayout.constant = self.middleViewTopSpaceLayoutConstant
                    }
            })
            return
        }
        let y = panGesture.translationInView(self.view).y
        middleViewTopSpaceLayout.constant = middleViewTopSpaceLayoutConstant + y
    }

}

