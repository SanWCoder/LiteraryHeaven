//
//  SWUserSetingController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/25.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWUserSetingController: SWBaseSettingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func addGroup()  {
        
        let group = SWBaseSettingGroup.init(headerText: "个人设置", footerText: "")
        group.items.append(SWBaseSettingImage.init(title: "个人资料", icon: nil, subImage: "more", subClass: SWUserInfoController()))
        group.items.append(SWBaseSettingImage.init(title: "修改密码", icon: nil, subImage: "more", subClass: nil))
        baseData.append(group)
        
        let groupOne = SWBaseSettingGroup.init(headerText: "消息设置", footerText: "")
        groupOne.items.append(SWBaseSettingSwitch.init(title: "收到评文时推送消息", icon: nil, subClass: nil))
        groupOne.items.append(SWBaseSettingSwitch.init(title: "收到评论时推送消息", icon: nil, subClass: nil))
        groupOne.items.append(SWBaseSettingSwitch.init(title: "收到赞时推送消息", icon: nil, subClass: nil))
        baseData.append(groupOne)
        
        let groupTwo = SWBaseSettingGroup.init(headerText: "其他设置", footerText: "")
        groupTwo.items.append(SWBaseSettingTextImage.init(title: "清除缓存", icon: nil, subTitle: "20.00m",subImage: "more", subClass: nil))
        groupTwo.items.append(SWBaseSettingImage.init(title: "关于我们", icon: nil,subImage: "more", subClass: SWAboutUsController()))
        groupTwo.items.append(SWBaseSettingTextImage.init(title: "检查更新", icon: nil, subTitle: "v1.1.1",subImage: "more", subClass: nil))
        groupTwo.items.append(SWBaseSettingImage.init(title: "给我们评分", icon: nil,subImage: "more", subClass: nil))
        baseData.append(groupTwo)
        self.tableView .reloadData()
    }
}
class SWUserInfoController: SWBaseSettingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func addGroup()  {
        let group = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group.items.append(SWBaseSettingImage.init(title: "头像", icon: nil, subImage: "more", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "笔名", icon: nil,subTitle: "少年不知愁滋味", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "联系方式", icon: nil, subTitle: "12*****888", subClass: nil))
        baseData.append(group)
        
        let group1 = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group1.items.append(SWBaseSettingTextImage.init(title: "性别", icon: nil, subTitle: "男",subImage: "more", subClass: nil))
        group1.items.append(SWBaseSettingImageText.init(title: "等级", icon: nil, subTitle: "资深用户",subImage: "vip_ple", subClass: nil))
        group1.items.append(SWBaseSettingTextImage.init(title: "简介", icon: nil, subTitle: "可能忙着忘了没时间写",subImage: "more", subClass: nil))
        baseData.append(group1)
        self.tableView .reloadData()
    }
}

class SWAboutUsController: SWBaseSettingController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func addGroup()  {
        let group = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group.items.append(SWBaseSettingText.init(title: "官网", icon: nil, subTitle: "www.wenyouhui.com", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "微信公众号", icon: nil, subTitle: "一路捞文友汇", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "新浪微博", icon: nil, subTitle: "一路捞文友汇", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "客服电话", icon: nil, subTitle: "400-xxxxx", subClass: nil))
        group.items.append(SWBaseSettingImage.init(title: "投稿须知", icon: nil, subImage: "more", subClass: SWSendArtiMsgController()))
        group.items.append(SWBaseSettingImage.init(title: "用户等级说明", icon: nil, subImage: "more", subClass: nil))
        baseData.append(group)
        
        self.tableView.reloadData()
    }
}
class SWSendArtiMsgController: SWBaseSettingController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func addGroup() {
        let group = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group.items.append(SWBaseSettingText.init(title: "在线投稿地址：www.wenyouhui.com", icon: nil, subTitle: "", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "投稿头像地址：wwenyouhui@16lao.com", icon: nil, subTitle: "", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "具体可咨询文友汇客服：400-xxxxx", icon: nil, subTitle: "", subClass: nil))
        baseData.append(group)
        
        self.tableView.reloadData()
    }
}
