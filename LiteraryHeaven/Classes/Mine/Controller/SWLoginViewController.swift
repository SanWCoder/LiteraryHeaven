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
class SWLoginViewController: UIViewController {
    @IBOutlet weak var forgetPwsBtn: UIButton!
    let disposeBag = DisposeBag()
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
        // 添加右边按钮
        addRightItem()
        // 使用Rx验证
        let iphoneObs = iphoneTF.rx.text.orEmpty
            .map({$0.characters.count >= 11})
            .shareReplay(1)
        
        let pwsObs = pwsTF.rx.text.orEmpty
            .map({$0.characters.count >= 6})
            .shareReplay(1)
        
        let enable = Observable.combineLatest(iphoneObs,pwsObs){
            $0 && $1}
            .shareReplay(1)
        enable.bind(to: confimBtn.rx.isEnabled)
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
    func register() {
        let registerVC = SWRegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    func forgetPws() {
        let registerVC = SWForgetPwsViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
    }
    func showAlert() {
        let alert : UIAlertController = UIAlertController(title: "登录", message: "登录成功", preferredStyle: .alert)
        let confim : UIAlertAction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confim)
        self.present(alert, animated: true, completion: nil)
    }
}
