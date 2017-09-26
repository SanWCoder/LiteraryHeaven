//
//  SWUserInfoModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/25.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWUserInfoModel: NSObject,NSCoding {
    // 用户ID
    var userId : Int?
    // 性别
    var sex : String?
    // 头像
    var header : String?
    // 联系电话
    var phone : String?
    // 笔名
    var nickName : String?
    // 认证（0未，1已）
    var auth : Int?
    // 等级（0普通，1资深）
    var level : Int?
    // 评论推送开关 0关 1开
    var comm : Int?
    // 点赞推送开关 0关 1开
    var pra : Int?
    // 个人简介
    var info : String?
    // token
    var token : String?
    /// 归档
    func encode(with aCoder: NSCoder) {
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(sex, forKey: "sex")
        aCoder.encode(header, forKey: "header")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(nickName, forKey: "nickName")
        aCoder.encode(auth, forKey: "auth")
        aCoder.encode(level, forKey: "level")
        aCoder.encode(comm, forKey: "comm")
        aCoder.encode(pra, forKey: "pra")
        aCoder.encode(info, forKey: "info")
        aCoder.encode(token, forKey: "token")
    }
    /// 解档
    required init?(coder aDecoder: NSCoder) {
        super.init()
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        sex = aDecoder.decodeObject(forKey: "sex") as? String
        header = aDecoder.decodeObject(forKey: "header") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        nickName = aDecoder.decodeObject(forKey: "nickName") as? String
        auth = aDecoder.decodeObject(forKey: "auth") as? Int
        level = aDecoder.decodeObject(forKey: "level") as? Int
        comm = aDecoder.decodeObject(forKey: "comm") as? Int
        pra = aDecoder.decodeObject(forKey: "pra") as? Int
        info = aDecoder.decodeObject(forKey: "info") as? String
        token = aDecoder.decodeObject(forKey: "token") as? String
    }
    override init() {
        super.init()
    }
}
