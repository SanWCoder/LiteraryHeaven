//
//  SWNavigationController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/19.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 设置Nav
        settingBar()
    }
    func settingBar()  {
       let bar = UINavigationBar.appearance()
       bar.barTintColor = kColor // 背景色
       bar.tintColor = kColor4 // item颜色
       bar.titleTextAttributes = [NSFontAttributeName:kFont2,NSForegroundColorAttributeName:kColor11] // 标题属性
    }
}
extension SWNavigationController
{
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            
            let backBtn = UIButton(type: .custom)
            backBtn.setImage(UIImage(named:"return"), for: .normal)
            backBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            backBtn.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    func back(sender : UIButton) {
        self.popViewController(animated: true)
    }
}

