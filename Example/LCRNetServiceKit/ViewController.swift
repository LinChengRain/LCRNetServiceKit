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

        LCRNetServiceKit.shared.requestData(requestType: .Post, headerParams: ["ws":"1.00","test":"2"], url: "https://testapi.bjy1314.com/app/api/ad/bannerStart", parameters: [String:Any]()) { (response) in
            print("success")
        } failure: { (AnyObject) in
            print("false")
        }

        LCRNetServiceKit.shared.isListener = false

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

