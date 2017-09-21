
//
//  SWConfig.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/19.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

/// 屏幕宽
let kScreenWidth = UIScreen.main.bounds.width
/// 屏幕高
let kScreenHeight = UIScreen.main.bounds.height
/// 圆角
let kRadius : CGFloat = 6
/// 导航栏高度
let kNavHeight : CGFloat = 64
/// 文字区域左右之间的间距
let kLeftMargin = 8
/// 文字区域上下之间的间距
let kTopMargin = 6
/// 列表上下留白
let kListMargin = 10
/// 常用字体
let KFont1 = FONT(18)
let kFont2 = FONT(17)
let kFont3 = FONT(15)
let kFont4 = FONT(12)
let kFont5 = FONT(11)
/// 常用颜色
let kColor = UIColor.hexInt(0xffffff)
/// 红色
let kColor1 = UIColor.hexInt(0xe1805e)
let kColor2 = UIColor.hexInt(0x000000)
let kColor3 = UIColor.hexInt(0xdddddd)
/// 主背景色
let kColor4 = UIColor.hexInt(0xf5f5f5)
let kColor5 = UIColor.hexInt(0x777777)
let kColor6 = UIColor.hexInt(0xfab114)
let kColor7 = UIColor.hexInt(0x999999)
let kColor8 = UIColor.hexInt(0x482d10)
let kColor9 = UIColor.hexInt(0xe6d5cf)
let kColor10 = UIColor.hexInt(0xd1714f)
let kColor11 = UIColor.hexInt(0x333333)
let kColor12 = UIColor.hexInt(0x666666)


/// 友盟账号
let kPushKey = "570cc349e0f55a0485000868"

let IP = "127.0.0.1"
/// 地址（加地址数据）
let kHomePageURL = "http://0.0.0.0:tuicool@api.tuicool.com/api/articles/hot.json?cid=0&size=30"
/// 登录地址
let kLoginURL = "http://localhost:8181/login"
/// 注册地址
let kRegisterURL = "http://localhost:8181/register"
/// 请求回调方法
typealias completeHander = (_ responseobject : AnyObject?,_ error : Error?) -> Void

/// 返回有透明度的颜色
func RGBA(_ r:CGFloat,g:CGFloat,b:CGFloat,a:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
/// 返回无透明度的颜色
func RGB(_ r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor {
    return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
}
/// 返回字体大小
func FONT(_ ofSize:CGFloat)-> UIFont{
    return UIFont.systemFont(ofSize: ofSize)
}

/// 颜色十六进制转化
extension UIColor{
   class func hexInt(_ hexValue: Int) -> UIColor {
        return UIColor(
            red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
