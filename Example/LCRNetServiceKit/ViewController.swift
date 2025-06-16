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

        let config = TestConfig("/app/api/ad/bannerStart",d: "首页_邀请banner图",m: .Post)
        LCRNetServiceKit.shared.baseRequest(config: config) { (response:BasicEntity<[Entity]>) in
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

public class TestConfig: LCRApiServiceProtocol {
    
    public var description: String
    
    public var extra: String?
    
    public var header: [String:String]? { ["ws":"1.00","test":"2"] }
    /// 域名 + path
    public var url: String {
        let urltr = "https://testapi.bjy1314.com"
        return urltr + URLPath + (extra ?? "")
    }
    
    public var method: LCRHttpRequestType = .Put
    
    private let URLPath: String  // URL的path
    
    init(_ path: String, d: String, e: String? = nil, m: LCRHttpRequestType = .Get) {
        URLPath = path
        description = d
        extra = e
        method = m
    }
}

public struct BasicEntity<T:Codable>: Codable {
    var status: Int
    var msg: String
    var data:T?
}

public struct Entity: Codable {

}

