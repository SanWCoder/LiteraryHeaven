//
//  SWTabBarController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/19.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SVProgressHUD
class SWTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 去掉默认的半透明色
        tabBar.isTranslucent = false
        // 设置主题颜色（默认为蓝色)
        tabBar.tintColor = kColor1
        addChildItem(childVc: SWHomePageController(), title: "首页", image: "home", seleImage: "home_sel")
        addChildItem(childVc: SWChannelController(), title: "频道", image: "category", seleImage: "category_sel")
        addChildItem(childVc: SWMineViewController(), title: "我的", image: "me", seleImage: "me_sel")
    }
    /// 添加item
    private func addChildItem(childVc:UIViewController,title:String,image:String,seleImage:String) -> Void {
        let item = UITabBarItem(title: title, image: UIImage.init(named: image), selectedImage: UIImage.init(named: seleImage))
        childVc.tabBarItem = item
        childVc.title = title
        addChildViewController(SWNavigationController(rootViewController: childVc))
    }
}
