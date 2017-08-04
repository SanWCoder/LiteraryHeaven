//
//  SWChannelController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/19.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWChannelController: UIViewController {
    /// 数据源
    lazy var titleArrData : [SWSlideMenuRootModel] = {
        var titleArrData : [SWSlideMenuRootModel] = [SWSlideMenuRootModel]()
        return titleArrData
    }()
    var slideView : SWSlideMenuView?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = kColor
        /// automaticallyAdjustsScrollViewInsets 影响布局
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.isNavigationBarHidden = true
        slideView = SWSlideMenuView(frame: CGRect(x: 0, y: kNavHeight - 20, width: self.view.frame.size.width, height: self.view.frame.size.height - kNavHeight - 20))
        slideView?.titleArrData = titleArrData
        slideView?.titleViewHeight = 35
        self.view.addSubview(slideView!)
        SWChannelViewModel.channelData { (titleArrData) in
            self.titleArrData = titleArrData!
            self.slideView?.titleArrData = self.titleArrData
        }
    }
}
