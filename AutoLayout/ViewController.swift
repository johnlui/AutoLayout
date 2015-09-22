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
    
    // for HiddenTopView
    var hiddenTopViewDefaultPosition: CGFloat!
    // for xiaoyun
    var xiaoyunOriginX: CGFloat!
    // for center image
    var middleImageViewHasBeenEnlarged = true
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var topLayoutConstraintOfMainView: NSLayoutConstraint!
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    @IBOutlet weak var hiddenTopView: UIView!
    @IBOutlet weak var topLayoutConstraintOfHiddenTopView: NSLayoutConstraint!
    
    @IBOutlet weak var dayunImageView: UIImageView!
    @IBOutlet weak var xiaoyunImageView: UIImageView!
    @IBOutlet weak var hiddenBannerImageView: UIImageView!
    
    @IBOutlet weak var leftDistanceOfDayun: NSLayoutConstraint!
    @IBOutlet weak var rightDistanceOfXiaoyun: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panGesture.addTarget(self, action: Selector("pan:"))
        mainViewTopSpaceLayoutConstraintValue = topLayoutConstraintOfMainView.constant
        mainViewOriginY = mainView.frame.origin.y
        
        // set default values of animated views
        hiddenTopViewDefaultPosition = -(hiddenTopView.frame.height/2)
        topLayoutConstraintOfHiddenTopView.constant = hiddenTopViewDefaultPosition
        rightDistanceOfXiaoyun.constant = 60
        
        xiaoyunOriginX = xiaoyunImageView.frame.origin.x
        
        makeDayunRolling()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pan(recongnizer: UIPanGestureRecognizer) {
        if panGesture.state == UIGestureRecognizerState.Ended {
            middleImageViewHasBeenEnlarged = true
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                recongnizer.view?.frame.origin.y = self.mainViewOriginY
                
                // make animated views move
                self.hiddenTopView.frame.origin.y = self.hiddenTopViewDefaultPosition
                self.xiaoyunImageView.frame.origin.x = self.xiaoyunOriginX
                self.hiddenBannerImageView.transform = CGAffineTransformMakeScale(1, 1)
                }, completion: { (success) -> Void in
                    if success {
                        self.topLayoutConstraintOfMainView.constant = self.mainViewTopSpaceLayoutConstraintValue
                        
                        // change animated views's constraints to make tem stable
                        self.topLayoutConstraintOfHiddenTopView.constant = self.hiddenTopViewDefaultPosition
                        self.rightDistanceOfXiaoyun.constant = 60
                    }
            })
            return
        }
        let y = panGesture.translationInView(self.view).y
        topLayoutConstraintOfMainView.constant = mainViewTopSpaceLayoutConstraintValue + y
        
        // move xiaoyun when pull
        let xiaoyunDistance = 60 - y * 0.5
        if xiaoyunDistance > -48 {
            rightDistanceOfXiaoyun.constant = xiaoyunDistance
        } else {
            // slow down xiaoyun's speed when it needs
            rightDistanceOfXiaoyun.constant = -sqrt(-xiaoyunDistance - 47) - 47
        }
        
        // move HiddenTopView when pull
        let distance = 0.3 * y + hiddenTopViewDefaultPosition
        if distance < 1 {
            topLayoutConstraintOfHiddenTopView.constant = distance
        } else {
            // slow down HiddenTopView's speed when it needs
            topLayoutConstraintOfHiddenTopView.constant =  sqrt(distance)
        }
        
        if mainViewTopSpaceLayoutConstraintValue + y > hiddenTopView.frame.height * 1.2 {
            if middleImageViewHasBeenEnlarged {
                enlargeMiddleImageView()
                middleImageViewHasBeenEnlarged = false
            }
        }
    }
    // make dayun rolling
    func makeDayunRolling() {
        leftDistanceOfDayun.constant -= 30
        UIView.animateWithDuration(0.8, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            // fix a bug in iOS 9
            //self.dayunImageView.layoutIfNeeded()
            self.hiddenTopView.layoutIfNeeded()
            }) { (success) -> Void in
                if success {
                    self.leftDistanceOfDayun.constant += 30
                    UIView.animateWithDuration(0.8, delay: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                        // fix a bug in iOS 9
                        //self.dayunImageView.layoutIfNeeded()
                        self.hiddenTopView.layoutIfNeeded()
                        }) { (success) -> Void in
                            if success {
                                self.makeDayunRolling()
                            }
                    }
                }
        }
    }
    // emlarg middle image
    func enlargeMiddleImageView() {
        UIView.animateWithDuration(0.5, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.hiddenBannerImageView.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }) { (success) -> Void in
                if success {
                    return
                }
        }
    }

}

