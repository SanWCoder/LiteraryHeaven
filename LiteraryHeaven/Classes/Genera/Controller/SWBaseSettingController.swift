//
//  SWBaseSettingController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/21.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD

class SWBaseSettingController: UIViewController {
    let  disposeBag = DisposeBag()
    
    lazy var baseData : [SWBaseSettingGroup] = {
        var baseData = [SWBaseSettingGroup]()
        return baseData
    }()
    lazy var tableView : UITableView = {
        var tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kColor4
        tableView.tableFooterView = UIView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(self.tableView)
        addGroup()
    }
    func addGroup() {
        
    }
}
extension SWBaseSettingController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.baseData[section].items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.baseData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SWBaseSettingCell = SWBaseSettingCell.baseCell(tableView: tableView)!
        let baseModel = self.baseData[indexPath.section].items[indexPath.row]
        cell.baseModel = baseModel
        return cell
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return self.baseData[section].footerText
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.baseData[section].headerText
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = kColor4
        var height = CGFloat()
        
        if (self.baseData[section].headerText?.isEmpty)! {
            height = 8
        }
        else{
            let size = self.baseData[section].headerText?.sizeWithString(font: kFont3, width: tableView.frame.size.width)
            
            height = 28 + (size?.height)!
            let headerLab = UILabel(frame: CGRect(origin: CGPoint.init(x: kLeftMargin, y: 19), size: size!))
            headerLab.textAlignment = .left
            headerLab.font = kFont3
            headerLab.textColor = kColor1
            headerLab.text = self.baseData[section].headerText
            headerView.addSubview(headerLab)
        }
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: height)
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height = CGFloat()
        if (self.baseData[section].headerText?.isEmpty)! {
            height = 8
        }
        else{
            let size = self.baseData[section].headerText?.sizeWithString(font: kFont3, width: tableView.frame.size.width)
            height = 28 + (size?.height)!
        }
        return height
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let baseModel = self.baseData[indexPath.section].items[indexPath.row]
        if baseModel.title == "简介" {
            let vc = SWUpdateUserInfoController()
            vc.isUpdateNickName = false
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        if (baseModel.subClass != nil) && (baseModel.subClass is UIViewController) {
            let viewController = baseModel.subClass as! UIViewController
            viewController.title = baseModel.title
           self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
