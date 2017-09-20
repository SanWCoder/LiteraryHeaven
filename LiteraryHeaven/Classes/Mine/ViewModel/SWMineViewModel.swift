//
//  SWMineViewModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/9/20.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SwiftyJSON
class SWMineViewModel: NSObject {

    typealias responseHandle = (_ responseData:[String:Any]) -> Void
    
  class func longin(phone:String,password:String,responseHandle:@escaping responseHandle) -> Void {
        let params : [String:Any] = ["phone":phone,"password":password]
        SWNetRequest.postRequestData(url: kLoginURL, parames:params ) { (response, error) in
            let json = JSON(response!).dictionaryObject
            responseHandle(json!)
        }
    }
}
