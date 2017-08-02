//
//  SWMineViewController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/19.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWMineViewController: SWBaseSettingController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = kColor4
        // 添加头
        addHeaderView()
        // 添加item
        addRightItem()
    }
    override func addGroup()  {
        let group = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group.items.append(SWBaseSettingImage.init(title: "我的投稿", icon: "my_submission", subImage: "more", subClass: SWHomePageController()))
        group.items.append(SWBaseSettingImage.init(title: "我的评文", icon: "my_article", subImage: "more", subClass: SWHomePageController()))
        group.items.append(SWBaseSettingImage.init(title: "我的评论", icon: "my_comment", subImage: "more", subClass: SWHomePageController()))
        group.items.append(SWBaseSettingImage.init(title: "我收藏的文章", icon: "my_collection", subImage: "more", subClass: SWHomePageController()))
        baseData.append(group)
        
        let group1 = SWBaseSettingGroup.init(headerText: "", footerText: "")
        group1.items.append(SWBaseSettingImage.init(title: "消息", icon: "news", subImage: "more", subClass: SWHomePageController()))
        baseData.append(group1)
        self.tableView .reloadData()
    }
    func addHeaderView() -> Void {
        let height : CGFloat = 81
        let headerView = SWMineHeaderVIew.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: height))
        headerView.delegate = self
        self.tableView.tableHeaderView = headerView
    }
    func addRightItem() -> Void {
        let rightItem = UIButton(type: .custom)
        rightItem.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        rightItem.setImage(UIImage(named:"set"), for: .normal)
        let BarItem = UIBarButtonItem(customView: rightItem)
        self.navigationItem.rightBarButtonItem = BarItem
        rightItem.addTarget(self, action: #selector(rightClick(sender:)), for: .touchUpInside)
    }
    
}
extension SWMineViewController : headerProtocol{
    func headerAction(sender:AnyObject){
        self.navigationController?.pushViewController(SWHomePageController(), animated: true)
    }
}
extension SWMineViewController{
    func rightClick(sender : UIButton) -> Void {
        let setVC = SWUserSetingController()
        setVC.title = "设置"
        self.navigationController?.pushViewController(setVC, animated: true)
    }
}
