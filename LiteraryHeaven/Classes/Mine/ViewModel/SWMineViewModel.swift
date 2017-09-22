//
//  SWMineViewModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/9/20.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import Kingfisher

class SWMineViewModel: NSObject {
    
    class func longin(phone:String,password:String,completeHander:@escaping completeHander) -> Void {
        let params : [String:Any] = ["phone":phone,"password":password.md5()]
        SWNetRequest.postRequestData(url: kLoginURL, parames:params ) { (response) in
            completeHander(response)
        }
    }
    class func register(phone:String,password:String,nickname:String,verify:String,completeHander:@escaping completeHander) -> Void {
        let params : [String:Any] = ["phone":phone,"password":password.md5(),"verify":verify,"nickname":nickname]
        SWNetRequest.postRequestData(url: kRegisterURL, parames:params ) { (response) in
            completeHander(response)
        }
    }
}
