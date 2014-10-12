//
//  ViewController.swift
//  SideBar
//
//  Created by Steven on 10/11/14.
//  Copyright (c) 2014 Steven. All rights reserved.
//

import UIKit

class MainController: UIViewController {
    var delegate:MenuDelegate?
    
    @IBAction func openLeft(sender: AnyObject) {
        if menuState == MenuState.Closed {
            delegate?.openMenu()
        } else {
            delegate?.closeMenu()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.redColor()
    }
    
}

