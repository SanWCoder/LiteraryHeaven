//
//  SWUserInfoModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/25.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWUserInfoModel: NSObject {
    // 用户ID
    var userId : Int?
    // 性别
    var sex : String?
    // 头像
    var img : String?
    // 联系电话
    var mobile : String?
    // 笔名
    var username : String?
    // 认证（0未，1已）
    var auth : Int?
    // 等级（0普通，1资深）
    var level : Int?
    // 评论推送开关 0关 1开
    var comm : Int?
    // 点赞推送开关 0关 1开
    var pra : Int?
    // 个人简介
    var content : String?
    
}
