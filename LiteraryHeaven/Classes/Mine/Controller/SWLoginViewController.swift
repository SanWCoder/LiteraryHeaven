//
//  SWLoginViewController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/17.
//  Copyright © 2017年 ONON. All rights reserved.
//
import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD
import SwiftyJSON
class SWLoginViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var forgetPwsBtn: UIButton!
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    @IBOutlet weak var confimBtn: UIButton!
    @IBOutlet weak var iphoneTF: UITextField!
    @IBOutlet weak var pwsTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        // 设置圆角
        topContraint.constant = topContraint.constant + kNavHeight
        confimBtn.layer.cornerRadius = kRadius
        confimBtn.layer.masksToBounds = true
        // Do any additional setup after loading the view.
        iphoneTF.keyboardType = .phonePad
        // 添加右边按钮
        addRightItem()
        // 使用Rx验证
        let iphoneValide = iphoneTF.rx.text.orEmpty
            .map({$0.characters.count >= 11})
            .shareReplay(1)
        
        let pwsValide = pwsTF.rx.text.orEmpty
            .map({$0.characters.count >= 6})
            .shareReplay(1)
        
        let enableValide = Observable.combineLatest(iphoneValide,pwsValide){
            $0 && $1}
            .shareReplay(1)
        
        enableValide.bind(to: confimBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        
        confimBtn.rx.tap
            .subscribe(onNext: { [weak self] in self?.showAlert() })
            .disposed(by: disposeBag)
        forgetPwsBtn.rx.tap
            .subscribe(onNext : {[weak self] in self?.forgetPws()})
            .disposed(by: disposeBag)
    }
    func addRightItem() -> Void {
        let rightItem = UIButton(type: .custom)
        rightItem.frame = CGRect(x: 0, y: 0, width: 60, height: 20)
        rightItem.setTitle("注册", for: .normal)
        rightItem.setTitleColor(kColor11, for: .normal)
        rightItem.titleLabel?.font = kFont2
        let BarItem = UIBarButtonItem(customView: rightItem)
        self.navigationItem.rightBarButtonItem = BarItem
        // 使用RX
        rightItem.rx.tap
            .subscribe(onNext:{ [weak self] in self?.register()} )
            .disposed(by: disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    func register() {
        let registerVC = SWRegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    func forgetPws() {
        let registerVC = SWForgetPwsViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    func showAlert() {
        SWMineViewModel.longin(phone:iphoneTF.text!, password: pwsTF.text!) { (response) in
            guard response["code"] as! Int != 400 else{
                SVProgressHUD .showError(withStatus:response["msg"] as! String)
                return
            }
            let code : Int = response["code"] as! Int
            guard code == 0 else{
                SVProgressHUD .showError(withStatus:response["msg"] as! String )
                return
            }
            SWCommonTool.saveUserInfo(userModel: SWUserInfoModel.mj_object(withKeyValues: (response["data"] as AnyObject) as! Dictionary<String,Any>)!)
            
            NotificationCenter.default.post(name: NSNotification.Name(kLoginSuccessNC), object: nil)
            SVProgressHUD .showSuccess(withStatus: "登录成功")
            self.navigationController?.popViewController(animated: true)
        }
    }
}
