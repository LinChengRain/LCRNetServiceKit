//
//  LCRBaseResponseHeader.swift
//  LCRNetServiceKit
//
//  Created by yuchanglin on 2021/5/12.
//

import Foundation

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
