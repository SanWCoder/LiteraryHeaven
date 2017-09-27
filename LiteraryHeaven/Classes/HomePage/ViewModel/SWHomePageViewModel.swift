//
//  SWHomePageViewModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/2.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SwiftyJSON
import MJExtension

class SWHomePageViewModel: NSObject {
    /// 回调方法
    typealias completeHander = (_ homeData:Array<SWArticleModel>?) -> Void
    
    class func homeData(completeHander : @escaping completeHander) -> Void {
        SWNetRequest.getRequestData(url: kHomePageURL, parames: nil) { (response) in
            if (response.keys.contains("code")) && response["code"] as! Int == 400 {
                return
            }
            var resonseData = Array<SWArticleModel>()
            let responseArr = response["articles"] as AnyObject
            print(response)
            for (index,subJson) in (responseArr as! Array<Dictionary<String, Any>>).enumerated()  {
                let model = SWArticleModel()
                model.articleImage = subJson["img"] as? String
                model.authorNick = subJson["feed_title"] as? String
                model.articleTitle = subJson["title"] as? String
                model.clickCount = subJson["rectime"] as? String
                if Int(index) == 0 {
                    model.isRecommend = true
                    model.articleImage = "http://preview.quanjing.com/pm0046/pm0046-4622um.jpg"
                }
                resonseData.append(model)
            }
            completeHander(resonseData)
        }
    }
    class func homeData(article:Int ,completeHander : @escaping completeHander) -> Void {
        SWNetRequest.getRequestData(url: kArticleURL, parames: nil) { (response) in
            if (response.keys.contains("code")) && response["code"] as! Int != 0 {
                return
            }
            var resonseData = Array<SWArticleModel>()
            let responseArr = response["data"] as AnyObject
            print(response)
            for (index,subJson) in (responseArr as! Array<Dictionary<String, Any>>).enumerated()  {
                let model : SWArticleModel = SWArticleModel.mj_object(withKeyValues: subJson)
                
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
