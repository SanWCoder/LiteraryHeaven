//
//  SWHomePageController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/19.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import SnapKit
import Kingfisher

class SWHomePageController: UIViewController {
    lazy var tableView : UITableView = {
        var tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight - 49), style: .plain)
        tableView.backgroundColor = kColor4
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 55
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    lazy var dataArr : [SWArticleModel] = {
        var dataArr = [SWArticleModel]()
        return dataArr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.isNavigationBarHidden = true
        self.automaticallyAdjustsScrollViewInsets = false
        /// 请求网路数据
        self.reloadData()
        self.view.backgroundColor = kColor
        /// 创建广告轮播
        let header  = SWAdveSlideView.init(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 278))
        header.dataSource = ["http://pic.qjimage.com/pm0063/high/pm0063-4552dk.jpg","http://preview.quanjing.com/pm0046/pm0046-4622um.jpg","http://pic.qjimage.com/pm0020/high/pm0020-2123if.jpg"]
        tableView.tableHeaderView = header
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
/// tableView代理
extension SWHomePageController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SWHomePageCell.homePageCell(tableView: tableView)
        cell?.articleMode = dataArr[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight : CGFloat = 0
        if dataArr[indexPath.row].isRecommend {
            cellHeight = 175
        }
        else{
           cellHeight = 95
        }
        return cellHeight
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = SWHomaPageSectionHeadView.sectionHeaderViewIdtifer(tableView: tableView)
        headerView?.sectionTitle = "散文天地"
        return headerView
    }
}
/// 请求网路数据
extension SWHomePageController {
    func reloadData() {
        Alamofire.request(kHomePageURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            print(response)
            let json = JSON(response.data!)
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
                self.dataArr.append(model)
            }
            self.tableView.reloadData()
        }
    }
}
