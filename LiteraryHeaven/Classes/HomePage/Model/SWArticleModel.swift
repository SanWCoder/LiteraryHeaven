//
//  SWArticleModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/20.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWArticleModel: NSObject {
    /// 文章id
    var articleId : Int?
    /// 文章标题
    var articleTitle : String?
    /// 作者昵称
    var authorNick : String?
    /// 作者头像
    var iconImage : String?
    /// 文章点击次数
    var clickCount : String?
    /// 文章图片
    var articleImage : String?
    /// 组标题
    var sectionTitle : String?
    /// 详情地址
    var webUrl : String?
    /// 是否有推荐
    var isRecommend : Bool
    override init() {
        isRecommend = false
        super.init()
    }
}
