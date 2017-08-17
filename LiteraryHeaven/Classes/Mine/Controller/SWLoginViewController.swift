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
    let disposeBag = DisposeBag()
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    @IBOutlet weak var confimBtn: UIButton!
    @IBOutlet weak var iphoneTF: UITextField!
    @IBOutlet weak var pwsTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        topContraint.constant = topContraint.constant + kNavHeight
        confimBtn.layer.cornerRadius = kRadius
        confimBtn.layer.masksToBounds = true
        // Do any additional setup after loading the view.
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
    }
    func showAlert() {
        let alertView = UIAlertView(
            title: "登录提醒",
            message: "登录提醒",
            delegate: nil,
            cancelButtonTitle: "登录成功"
        )
        alertView.show()
    }
}
