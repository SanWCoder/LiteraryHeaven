//
//  SWBaseSettingModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/21.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
/// 基类模型
class SWBaseSettingModel: NSObject {
    var title : String?
    var icon : String?
    var subClass : AnyObject?
    
    override init() {
        super.init()
    }
    init(title : String,icon : String?,subClass : AnyObject?){
        self.title = title
        self.icon = icon
        self.subClass = subClass
    }
}
/// 组模型
class SWBaseSettingGroup: NSObject {
    var headerText : String?
    var footerText : String?
    var items : [SWBaseSettingModel] = []
    override init() {
        super.init()
    }
    init(headerText : String,footerText : String) {
        self.headerText = headerText
        self.footerText = footerText
    }
}
/// 纯图片模型
class SWBaseSettingImage: SWBaseSettingModel {
    var subImage : String?
    init(title : String, icon : String?,subImage : String ,subClass : AnyObject?) {
        self.subImage = subImage
        super.init(title : title, icon : icon ,subClass : subClass)
    }
}
/// 纯文字模型
class SWBaseSettingText: SWBaseSettingModel {
    var subTitle : String?
    override init() {
        super.init()
    }
    init(title : String, icon : String?,subTitle:String ,subClass : AnyObject?) {
        self.subTitle = subTitle
        super.init(title : title, icon : icon,subClass : subClass)
    }
}
/// 图片 + 文字模型
class SWBaseSettingImageText: SWBaseSettingModel {
    var subImage : String?
    var subTitle : String?
    init(title : String, icon : String?,subTitle :String,subImage : String ,subClass : AnyObject?) {
        self.subImage = subImage
        self.subTitle = subTitle
        super.init(title: title, icon: icon,subClass : subClass)
    }
}
/// 文字 + 图片模型
class SWBaseSettingTextImage: SWBaseSettingModel {
    var subImage : String?
    var subTitle : String?
    override init() {
        super.init()
    }
    init(title : String, icon : String?,subTitle :String,subImage : String ,subClass : AnyObject?) {
        self.subImage = subImage
        self.subTitle = subTitle
        super.init(title: title, icon: icon,subClass : subClass)
    }
}
/// 开关模型
class SWBaseSettingSwitch: SWBaseSettingModel {
    
}

