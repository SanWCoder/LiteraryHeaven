//
//  SWCommonTool.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/9/26.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
/// 用户信息地址
let userInfoPath =   (NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                          FileManager.SearchPathDomainMask.userDomainMask,true).first!).appending("userInfo.data")
class SWCommonTool: NSObject {
    
    /// 存储用户登录信息
    ///
    /// - Parameter userModel: <#userModel description#>
    /// - Returns: <#return value description#>
   class func saveUserInfo(userModel : SWUserInfoModel) -> Bool {
        
        return NSKeyedArchiver.archiveRootObject(userModel, toFile:userInfoPath)
    }
    
    /// 获取用户登录信息
    ///
    /// - Returns: <#return value description#>
   class func userInfo() -> SWUserInfoModel? {
        guard NSKeyedUnarchiver.unarchiveObject(withFile:userInfoPath) != nil else {
            return nil
        }
        return (NSKeyedUnarchiver.unarchiveObject(withFile:userInfoPath) as? SWUserInfoModel)!
    }
    
    
}
