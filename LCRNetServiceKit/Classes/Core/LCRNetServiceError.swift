//
//  LCRNetServiceError.swift
//  LCRNetServiceKit_Example
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

enum LCRNetServiceError: Error {
    /// 普通的错误信息
    case error(errorMessage: String)
    /// 数据不是json格式
    case dataJSON(errorMessage: String)
    /// 数据不匹配
    case dataMatch(errorMessage: String)
    /// 数据为空
    case dataEmpty(errorMessage: String)
    /// 网络错误
    case netError(errorMessage: String)
    /// 网络错误的信息打印
    ///
    /// - Parameter error: 错误信息
    /// - Returns: 网络错误处理
    static func apiError(with error: NSError) -> LCRNetServiceError {
        print("This error message is \(error)")
        if error.domain == "Alamofire.AFError" {
            //处理自带的错误
            if error.code == 4 {
                return LCRNetServiceError.dataEmpty(errorMessage: "数据为空")
            }
        }
        return LCRNetServiceError.netError(errorMessage: "未知网络错误")
    }
}
