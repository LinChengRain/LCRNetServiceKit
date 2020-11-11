//
//  ViewController.swift
//  LCRNetServiceKit
//
//  Created by LinChengRain on 11/11/2020.
//  Copyright (c) 2020 LinChengRain. All rights reserved.
//

import UIKit
import LCRNetServiceKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        LCRNetServiceKit.shared.requestData(url: "http://47.99.76.125:8091/api/learn/home/inviteBanner") { (response) in
            
        } fail: { (AnyObject) in
            
        }


        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

