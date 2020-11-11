//
//  LCRNetServiceKit.swift
//  LCRNetServiceKit_Example
//
//  Created by apple on 2020/11/10.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire
/// 宏定义请求成功的block
public typealias ResponseSuccess = (_ response: AnyObject) -> Void
/// 宏定义请求失败的block
public typealias ResponseFail = (_ error: AnyObject) -> Void
/// 上传或者下载的进度
public typealias ProgressResult =  (Double) -> Void//进度
/// 状态码
public typealias NetworkStatus = (_ LCNetworkStatus: Int32) -> Void

public enum LCRNetServiceStatus: Int32 {
     case  HttpUnknow       = -1  //未知
     case  HttpNoReachable  = 0  // 无网络
     case  HttpWwan         = 1   //2g ， 3g 4g
     case  HttpWifi         = 2  // wifi
}

///  网络请求的类型
public enum LCRHttpRequestType {
    case Get
    case Post
    case JsonPost
}

public class LCRNetServiceKit: NSObject {
    
    private var request:DataRequest?
    
    public static let shared = LCRNetServiceKit()
    
    public var networkStatus: LCRNetServiceStatus = LCRNetServiceStatus.HttpWifi

}

extension LCRNetServiceKit{
    
    /// 取消网络
    public func cancel() {
        guard let request = self.request else { return }
        request.cancel()
    }
    /// 取消所有请求
    public func cancelAllRequests() {
        AF.cancelAllRequests {
            
        }
    }
    /// 取消指定 url 的请求
    public func cancel(_ url:String) {
        AF.withAllRequests { (activeRequests) in
            activeRequests.forEach {
                //只取消指定url的请求
                if ($0.request?.url?.absoluteString == url) {
                    $0.cancel()
                }
            }
        }
    }
    
    ///  POST/GET
    ///
    /// - Parameters:
    ///   - requestType: 请求方式
    ///   - headerParams: 响应头参数
    ///   - url: 请求网址路径
    ///   - params:  请求参数
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public func requestData(requestType: LCRHttpRequestType = .Post,headerParams: String? = nil, url:  String ,parameters: [String:Any]? = nil,success:@escaping ResponseSuccess,fail: @escaping ResponseFail){
        
        if url.isEmpty || url.count <= 0  {
            return;
        }
        
//        if let parameter = parameters {
//            print("请求参数:\(parameter)")
//        }
//        print("调用接口:\(url)")
        // 配置header
        let  headers :HTTPHeaders? = signAndToken(headerParams)
        
        // 配置请求方式
        switch requestType {
        case .Get:
            self.getRequest(headers,url: url, parameters: parameters, success: success, fail: fail)
        case .Post:
            self.postRequest(headers,url: url, parameters: parameters, success: success, fail: fail)
        case .JsonPost:
            self.postRequest(headers,url: url, parameters: parameters, success: success, fail: fail)
        }
    }
    
    /// post 请求
    ///
    /// - Parameters:
    ///   - headers: 响应头参数
    ///   - url: 请求网址路径
    ///   - parameters:  请求参数
    ///   - success: 成功回调
    ///   - fail: 失败回调
    private func postRequest(_ headers:HTTPHeaders? = nil,url:  String ,parameters: [String:Any]? = nil,success:@escaping ResponseSuccess,fail: @escaping ResponseFail){
        
       request = AF.request(url, method: .post, parameters: parameters, headers: headers).responseJSON { [weak self] (response) in
            guard let self = self else { return }
            self.handleResponse(response: response, success: success, fail: fail)
        }
    }
    
    /// get 请求
    ///
    /// - Parameters:
    ///   - headers: 响应头参数
    ///   - url: 请求网址路径
    ///   - parameters:  请求参数
    ///   - success: 成功回调
    ///   - fail: 失败回调
    
    private func getRequest(_ headers:HTTPHeaders?, url: String ,parameters: [String:Any]? = nil,success:@escaping ResponseSuccess,fail: @escaping ResponseFail){
        
        request = AF.request(url, method: .get, parameters: parameters, headers: headers).responseJSON { [weak self] (response) in
            guard let self = self else { return }
            self.handleResponse(response: response, success: success, fail: fail)
        }
    }
    
    
    /// 上传图片
    ///
    /// - Parameters:
    ///   - url: 请求网址路径
    ///   - parameters:  请求参数
    ///   - imageData: 图片二进制数据
    ///   - fileName: 文件命名空间
    ///   - headers: 响应头参数
    ///   - progressBlock: 进度
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public func uploadImage(url:String ,parameters: [String:Any]? = nil, imageData: Data,fileName:String?, headerParams:String? = nil,progressBlock:@escaping ProgressResult,success:@escaping ResponseSuccess,fail: @escaping ResponseFail){
        
        if url.isEmpty || url.count <= 0  {
            return;
        }
        // 配置header
        let  headers :HTTPHeaders? = signAndToken(headerParams)
        request = AF.upload(multipartFormData: { (multipartFormData) in
            /** 采用post表单上传,参数解释：
             *  withName:和后台服务器的name要一致;
             *  fileName:可以充分利用写成用户的id，但是格式要写对;
             *   mimeType：规定的，要上传其他格式可以自行百度查一下
             */
            multipartFormData.append(imageData, withName: "file",fileName: "image.jpg",mimeType: "image/jpg")
        }, to: url,headers: headers).uploadProgress { (progress) in
//            print("Upload Progress: \(progress.fractionCompleted)")
            progressBlock(progress.fractionCompleted);
        }.responseJSON { (response) in
            self.handleResponse(response: response, success: success, fail: fail)
        }
    }
    
    
    /// 上传视频
    ///
    /// - Parameters:
    ///   - url: 请求网址路径
    ///   - parameters:  请求参数
    ///   - video: 视频二进制数据
    ///   - fileName: 文件命名空间
    ///   - headers: 响应头参数
    ///   - progressBlock: 进度
    ///   - success: 成功回调
    ///   - fail: 失败回调
    public func uploadVideo( url:String ,parameters: [String:Any]? = nil, video: Data,fileName:String?, headerParams:String?,progressBlock:@escaping ProgressResult,success:@escaping ResponseSuccess,fail: @escaping ResponseFail){
        
        let  headers :HTTPHeaders? = signAndToken(headerParams)
        request = AF.upload(multipartFormData: { (multipartFormData) in
            /** 采用post表单上传,参数解释：
             *  withName:和后台服务器的name要一致;
             *  fileName:可以充分利用写成用户的id，但是格式要写对;
             *   mimeType：规定的，要上传其他格式可以自行百度查一下
             */
            multipartFormData.append(video, withName: fileName ?? "file", fileName: "video.mp4", mimeType: "video/mp4")
        }, to: url,headers: headers).uploadProgress { (progress) in
            progressBlock(progress.fractionCompleted);
        }.responseJSON { (response) in
            self.handleResponse(response: response, success: success, fail: fail)
        }
    }
    
    // MARK: - 处理响应
    private func handleResponse(response:AFDataResponse<Any>,success:@escaping ResponseSuccess,fail:@escaping ResponseFail){

        switch response.result {
        case .success(let value):
            success(value as AnyObject)
        case .failure(let error):
            fail(error as AnyObject)
        }
    }
    
    // MARK: - 设置请求头
    private func signAndToken(_ headerParams:String?) -> HTTPHeaders?{
        
        guard headerParams != nil else { return nil }
//        print("header:\(headerParams ?? "")")
        return ["Authorization":headerParams!];
    }
    
}
