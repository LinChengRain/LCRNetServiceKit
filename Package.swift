// swift-tools-version:5.9
//
//  Package@swift-5.9.swift
//
//  Copyright (c) 2022 Alamofire Software Foundation (http://alamofire.org/)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import PackageDescription

let package = Package(name: "LCRNetServiceKit",
                      platforms: [.macOS(.v10_13),
                                  .iOS(.v12),
                                  .tvOS(.v12),
                                  .watchOS(.v4)],
                      products: [
                          .library(name: "LCRNetServiceKit", targets: ["LCRNetServiceKit"])
                      ],
                      dependencies: [
                        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.10.2"),
                        .package(url: "https://github.com/ashleymills/Reachability.swift.git", from: "5.2.4")
                      ],
                      targets: [
                        .target(
                           name:  "LCRNetServiceKit",
                           dependencies: [
                            .product(name: "Alamofire", package: "Alamofire"),
                            .product(name: "Reachability", package: "Reachability.swift")
                           ],
                           path: "Sources",
                           resources: [.process("PrivacyInfo.xcprivacy")]
                        )
                      ],
                      swiftLanguageVersions: [.v5]
)
