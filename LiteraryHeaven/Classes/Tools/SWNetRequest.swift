//
//  SWNetRequest.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/2.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import Alamofire
class SWNetRequest: NSObject {
//    /// 回调方法
//    typealias completeHander = (_ responseobject : AnyObject?,_ error : Error?) -> Void
    /// get请求
    public class func getRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .get, url: url, parames: parames) { (responseObject, error) in
            response(responseObject, error)
        }
    }
    /// post请求
    public class func postRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .post, url: url, parames: parames) { (responseObject, error) in
            response(responseObject, error)
        }
    }
    /// put请求
    public class func putRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .put, url: url, parames: parames) { (responseObject, error) in
            response(responseObject, error)
        }
    }
    /// delete请求
    public class func deleteRequestData(url : String,parames : Dictionary<String, Any>?,response :  @escaping completeHander){
        requestData(method: .delete, url: url, parames: parames) { (responseObject, error) in
            response(responseObject, error)
        }
    }
    /// 网络请求
    fileprivate class func requestData(method:HTTPMethod,url : String,parames : Dictionary<String, Any>?,response : @escaping completeHander){
        Alamofire.request(url, method: method, parameters: parames, encoding: URLEncoding.default, headers: nil).responseJSON { (jsonResponse) in
            /// 返回值
            jsonResponse.data != nil ? response(jsonResponse.data! as AnyObject,nil) :
            response(nil,jsonResponse.result.error)
        }
    }
    
}
