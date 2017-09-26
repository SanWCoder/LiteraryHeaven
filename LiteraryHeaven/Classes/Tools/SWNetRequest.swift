//
//  SWNetRequest.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/2.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class SWNetRequest: NSObject {
//    /// 回调方法
//    typealias completeHander = (_ responseobject : AnyObject?,_ error : Error?) -> Void
    /// get请求
    public class func getRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .get, url: url, parames: parames) { (responseObject) in
            response(responseObject)
        }
    }
    /// post请求
    public class func postRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .post, url: url, parames: parames) { (responseObject) in
            response(responseObject)
        }
    }
    /// put请求
    public class func putRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .put, url: url, parames: parames) { (responseObject) in
            response(responseObject)
        }
    }
    /// delete请求
    public class func deleteRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .delete, url: url, parames: parames) { (responseObject) in
            response(responseObject)
        }
    }
    /// 网络请求
    fileprivate class func requestData(method:HTTPMethod,url : String,parames : Dictionary<String, Any>?,response : @escaping completeHander){
        var header : [String : String] = [:]
        let token = SWCommonTool.userInfo()
        print(token ?? SWUserInfoModel())
        if (PTKeyChainStore.uuid() != nil) {
            header["uuid"] = PTKeyChainStore.uuid()
        }
        if token != nil {
            header["token"] = token?.token
        }
        Alamofire.request(url, method: method, parameters: parames, encoding: URLEncoding.default, headers: header).responseJSON { (jsonResponse) in
            print("jsonResponse == \(jsonResponse) + jsonResponse.data == \(String(describing: jsonResponse.data)) + jsonResponse.result == \(jsonResponse.result)")
            /// 返回值
            jsonResponse.result.isSuccess ? response(JSON(data: jsonResponse.data!).dictionaryObject!) :
            response(["code":400,"data":[],"msg":jsonResponse.result.error?.localizedDescription ?? "网络连接错误"])
        }
    }
    
}
