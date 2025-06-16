//
//  LCRNetServiceProtocol.swift
//  LCRNetServiceKit
//
//  Created by apple on 2021/2/22.
//

import Foundation

/// API interface protocol
public protocol LCRApiServiceProtocol {
    /// API URL address
    var url: String { get }
    /// API description information
    var description: String { get }
    /// API additional information, eg: Author | Note...
    var extra: String? { get }
    /// API header
    var header: [String:String]? { get }
    /// Type representing HTTP methods.
    var method: LCRHttpRequestType { get }
}

public struct LCRMultipartForm {
    var name: String
    var fileName: String
    var type: String
    var data: Data
}
