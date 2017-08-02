//
//  SWHomePageViewModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/2.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SwiftyJSON

class SWHomePageViewModel: NSObject {
    /// 回调方法
    typealias completeHander = (_ homeData:Array<SWArticleModel>?) -> Void
   class func homeData(completeHander : @escaping completeHander) -> Void {
        SWNetRequest.getRequestData(url: kHomePageURL, parames: nil) { (response, error) in
            if error != nil {
                return
            }
            var resonseData = Array<SWArticleModel>()
            let json = JSON(response!)
            print(json)
            for (index,subJson):(String, JSON) in json["articles"] {
                let model = SWArticleModel()
                model.articleImage = subJson["img"].stringValue
                model.authorNick = subJson["feed_title"].stringValue
                model.articleTitle = subJson["title"].stringValue
                model.clickCount = subJson["rectime"].stringValue
                if Int(index) == 0 {
                    model.isRecommend = true
                    model.articleImage = "http://preview.quanjing.com/pm0046/pm0046-4622um.jpg"
                }
                resonseData.append(model)
            }
            completeHander(resonseData)
        }
    }
}
