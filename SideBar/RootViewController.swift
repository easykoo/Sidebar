//
//  RootController.swift
//  SideBar
//
//  Created by Steven on 10/11/14.
//  Copyright (c) 2014 Steven. All rights reserved.
//

import UIKit

public enum MenuState: Int {
    case Opened
    case Closed
}

protocol MenuDelegate {
    func openMenu()
    func closeMenu()
}

var menuState:MenuState = MenuState.Closed

class RootViewController: UIViewController, MenuDelegate {

    var mainController:UINavigationController!
    var leftController:UIViewController!
    
    var tapRecognizer:UITapGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var storyboard = UIStoryboard(name: "Main", bundle: nil)
        mainController = storyboard.instantiateViewControllerWithIdentifier("MainController") as UINavigationController
        (mainController.viewControllers[0] as MainController).delegate = self
        leftController = storyboard.instantiateViewControllerWithIdentifier("LeftController") as UIViewController
        self.view.addSubview(mainController.view)
        
        mainController.view.frame = self.view.bounds
        mainController.view.layer.shadowRadius = 10.0
        mainController.view.layer.shadowOpacity = 0.8
        self.view.addSubview(leftController.view)
        
        leftController.view.frame = self.view.bounds
        self.view.bringSubviewToFront(mainController.view)
        
        var panGesture = UIPanGestureRecognizer(target: self, action: Selector("pan:"))
        self.mainController.view.addGestureRecognizer(panGesture)
        
        self.tapRecognizer = UITapGestureRecognizer(target: self, action: Selector("closeMenu"))
    }
    
    func pan(panGesture:UIPanGestureRecognizer) {
        switch panGesture.state {
        case .Changed:
            var point = panGesture.translationInView(self.view)
            
            if point.x > 0 || panGesture.view!.center.x > self.view.center.x {
                panGesture.view?.center = CGPointMake(panGesture.view!.center.x + point.x, panGesture.view!.center.y)
                panGesture.setTranslation(CGPointMake(0, 0), inView: self.view)
            }
        case .Ended, .Failed:
            if mainController.view.frame.origin.x > self.view.frame.origin.x + 100{
                openMenu()
            } else {
                closeMenu()
            }
        default:
            break
        }
    }
    
    func openMenu() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseIn)
        mainController.view.frame = CGRectMake(200, mainController.view.frame.origin.y, mainController.view.frame.size.width, mainController.view.frame.size.height)
        UIView.commitAnimations()
        menuState = MenuState.Opened
        
        mainController.view.addGestureRecognizer(self.tapRecognizer!)
    }
    
    func closeMenu() {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.EaseIn)
        mainController.view.frame = CGRectMake(0, mainController.view.frame.origin.y, mainController.view.frame.size.width, mainController.view.frame.size.height)
        UIView.commitAnimations()
        menuState = MenuState.Closed
        
        mainController.view.removeGestureRecognizer(self.tapRecognizer!)
    }
}
