//
//  SWUserSetingController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/25.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SVProgressHUD

class SWUserSetingController: SWBaseSettingController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        addQuitBtn()
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
    func addQuitBtn() {
        let quitBtn : UIButton = UIButton(type: .custom)
        quitBtn.setTitle("退出登录", for: .normal)
        quitBtn.backgroundColor = UIColor.white
        quitBtn.titleLabel?.font = kFont2
        quitBtn.setTitleColor(kColor1, for: .normal)
        quitBtn.addTarget(self, action: #selector(quit), for: .touchUpInside)
        quitBtn.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 60)
        self.tableView.tableFooterView = quitBtn
    }
    func quit(){
        SWNetRequest.putRequestData(url: kQuitURL, parames: nil) { (response) in
            guard response["code"] as! Int != 400 else{
                SVProgressHUD .showError(withStatus:response["msg"] as! String)
                return
            }
            let code : Int = response["code"] as! Int
            guard code == 0 else{
                SVProgressHUD .showError(withStatus:response["msg"] as! String )
                return
            }
            SWCommonTool.saveUserInfo(userModel: SWUserInfoModel())
            NotificationCenter.default.post(name: NSNotification.Name(kLoginSuccessNC), object: nil)
            SVProgressHUD .showSuccess(withStatus: "退出成功")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
class SWUserInfoController: SWBaseSettingController {
    var nickText : SWBaseSettingText = SWBaseSettingText()
    var infoText : SWBaseSettingTextImage = SWBaseSettingTextImage()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(updataData), name: NSNotification.Name(rawValue: kLoginSuccessNC), object: nil)
    }
    override func addGroup()  {
        let group = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group.items.append(SWBaseSettingImage.init(title: "头像", icon: nil, subImage: "more", subClass: nil))
        nickText = SWBaseSettingText.init(title: "昵称", icon: nil,subTitle: (SWCommonTool.userInfo()?.nickName)!, subClass: SWUpdateUserInfoController());
        group.items.append(nickText)
        group.items.append(SWBaseSettingText.init(title: "联系方式", icon: nil, subTitle: (SWCommonTool.userInfo()?.phone)!, subClass: nil))
        baseData.append(group)
        
        let group1 = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group1.items.append(SWBaseSettingTextImage.init(title: "性别", icon: nil, subTitle: (SWCommonTool.userInfo()?.sex)!,subImage: "more", subClass: nil))
        group1.items.append(SWBaseSettingImageText.init(title: "等级", icon: nil, subTitle: "资深用户",subImage: "vip_ple", subClass: nil))
        infoText = SWBaseSettingTextImage.init(title: "简介", icon: nil, subTitle: (SWCommonTool.userInfo()?.info)!,subImage: "more", subClass:nil)
        group1.items.append(infoText)
        baseData.append(group1)
        self.tableView .reloadData()
    }
    func updataData() {
        infoText.subTitle = SWCommonTool.userInfo()?.info
        nickText.subTitle = SWCommonTool.userInfo()?.nickName
        self.tableView.reloadData()
    }
}

class SWAboutUsController: SWBaseSettingController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func addGroup()  {
        let group = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group.items.append(SWBaseSettingText.init(title: "官网", icon: nil, subTitle: "www.LiteraryHeaven.com", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "微信公众号", icon: nil, subTitle: "婚杂志", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "新浪微博", icon: nil, subTitle: "婚杂志", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "客服电话", icon: nil, subTitle: "400-xxxxx", subClass: nil))
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
        group.items.append(SWBaseSettingText.init(title: "在线投稿地址：www.LiteraryHeaven.com", icon: nil, subTitle: "", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "投稿头像地址：LiteraryHeaven@163.com", icon: nil, subTitle: "", subClass: nil))
        group.items.append(SWBaseSettingText.init(title: "具体可咨询婚杂志客服：400-xxxxx", icon: nil, subTitle: "", subClass: nil))
        baseData.append(group)
        
        self.tableView.reloadData()
    }
}
