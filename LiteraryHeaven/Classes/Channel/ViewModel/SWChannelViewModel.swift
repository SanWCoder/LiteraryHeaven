//
//  SWChannelViewModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/3.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
/// 频道页ViewModel
class SWChannelViewModel: NSObject {
    typealias channelTitleArr = (_ channelData : Array<SWSlideMenuRootModel>?) -> Void
    /// 频道页数据
    class func channelData(completeHander : @escaping channelTitleArr) {
//        SWNetRequest.getRequestData(url: "http://www.baidu.com", parames: ["keyword":"文章","cid":10,"order":"hit’"]) { (responseData, error) in
            /// 数据源
            var titleArrData : [SWSlideMenuRootModel] = [SWSlideMenuRootModel]()
            /// 第一组
            let root = SWSlideMenuRootModel()
            root.itemTitle = "婚礼筹备"
            root.isSelected = true
            
            let model = SWSlideMenuSubModel()
            model.itemTitle = "婚礼流程"
            let Vc = SWHomePageController()
            Vc.view.backgroundColor = UIColor.yellow
            model.itemViewController = Vc
            model.isSelected = true
            let model1 = SWSlideMenuSubModel()
            model1.itemTitle = "求婚"
            let Vc1 = SWHomePageController()
            Vc1.view.backgroundColor = UIColor.orange
            model1.itemViewController = Vc1
            
            
            let modelAtt = SWSlideMenuSubModel()
            modelAtt.itemTitle = "婚礼"
            let VcAtt = SWHomePageController()
            VcAtt.view.backgroundColor = UIColor.blue
            modelAtt.itemViewController = VcAtt
            root.subItems?.append(model)
            root.subItems?.append(model1)
            root.subItems?.append(modelAtt)
            /// 第二组
            let root1 = SWSlideMenuRootModel()
            root1.itemTitle = "婚纱照"
            
            let model2 = SWSlideMenuSubModel()
            model2 .itemTitle = "婚纱风格"
            let Vc2 = SWHomePageController()
            Vc2.view.backgroundColor = UIColor.blue
            model2.itemViewController = Vc2
            let model3 = SWSlideMenuSubModel()
            model3.itemTitle = "旅拍"
            let Vc3 = SWHomePageController()
            Vc3.view.backgroundColor = UIColor.red
            model3.itemViewController = Vc3
            
            let modelAtt1 = SWSlideMenuSubModel()
            modelAtt1.itemTitle = "景点"
            let VcAtt1 = SWHomePageController()
            VcAtt1.view.backgroundColor = UIColor.blue
            modelAtt1.itemViewController = VcAtt1
            root1.subItems?.append(model2)
            root1.subItems?.append(model3)
            root1.subItems?.append(modelAtt1)
            
            /// 第三组
            let root2 = SWSlideMenuRootModel()
            root2.itemTitle = "婚礼现场"
            
            let model4 = SWSlideMenuSubModel()
            model4 .itemTitle = "婚礼布置"
            let Vc4 = SWHomePageController()
            Vc4.view.backgroundColor = UIColor.blue
            model4.itemViewController = Vc4
            
            let model5 = SWSlideMenuSubModel()
            model5.itemTitle = "婚礼致辞"
            let Vc5 = SWHomePageController()
            Vc5.view.backgroundColor = UIColor.red
            model5.itemViewController = Vc5
            
            let model6 = SWSlideMenuSubModel()
            model6.itemTitle = "婚礼音乐"
            let Vc6 = SWHomePageController()
            Vc6.view.backgroundColor = UIColor.blue
            model6.itemViewController = Vc6
            
            root2.subItems?.append(model4)
            root2.subItems?.append(model5)
            root2.subItems?.append(model6)
            
            titleArrData.append(root)
            titleArrData.append(root1)
            titleArrData.append(root2)

            completeHander(titleArrData)
        }
//    }
}
