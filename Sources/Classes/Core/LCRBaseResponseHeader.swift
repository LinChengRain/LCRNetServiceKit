//
//  LCRBaseResponseHeader.swift
//  LCRNetServiceKit
//
//  Created by yuchanglin on 2021/5/12.
//

import Foundation

/// 宏定义请求成功的block
public typealias LCRCompleteResult = (_ status: Bool,_ data:AnyObject,_ msg:LCRValidationResult?) -> Void

public typealias LCRCompleteOtherResult = (_ result: Bool,_ data:AnyObject,_ msg:LCRValidationResult?,_ extra:LCRExtraObj?) -> Void

/// 其他返回信息
public struct LCRExtraObj {
    var total:Int = 1
    var page:Int = 0
    var end:Bool = false
    var code:Int = 200
}

///结果验证
public enum LCRValidationResult {
    case ok
    case otherLogin
    case success(_ message:String)
    case empty
    case validating
    case failed(message: String)
}

public extension LCRValidationResult {
    var isValid: Bool {
        switch self {
            case .ok:
                return true
            default:
                return false
        }
    }
}
