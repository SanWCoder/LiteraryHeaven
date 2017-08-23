//
//  SWRegisterViewController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/18.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class SWRegisterViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var remindPwsLab: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var remindNickLable: UILabel!
    @IBOutlet weak var takeCodeBtn: UIButton!
    @IBOutlet weak var nickNameTF: UITextField!
    @IBOutlet weak var verifiCodeTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "注册"
        // 设置圆角
        topContraint.constant = topContraint.constant + kNavHeight
        takeCodeBtn.layer.cornerRadius = kRadius
        takeCodeBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = kRadius
        registerBtn.layer.masksToBounds = true
        phoneTF.keyboardType = .phonePad
        verifiCodeTF.keyboardType = .numberPad
        
        // 验证
        let phoneValide = phoneTF.rx.text.orEmpty
            .map { $0.characters.count >= 11}
        let verifiValide = verifiCodeTF.rx.text.orEmpty
            .map({$0.characters.count >= 4})
        let nickValide = nickNameTF.rx.text.orEmpty
            .map({$0.characters.count >= 4 && $0.characters.count <= 16})
        let passwordValide = passwordTF.rx.text.orEmpty
            .map({$0.characters.count >= 6 && $0.characters.count <= 16})
        phoneValide
            .bind(to: takeCodeBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        nickValide
            .bind(to: remindNickLable.rx.isHidden)
            .disposed(by: disposeBag)
        passwordValide
            .bind(to: remindPwsLab.rx.isHidden)
            .disposed(by: disposeBag)
        let allValide = Observable.combineLatest(phoneValide,verifiValide,nickValide,passwordValide){$0 && $1 && $2 && $3}
        allValide
            .bind(to: registerBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        registerBtn.rx.tap
            .subscribe(onNext:{[weak self] in self?.register()})
            .disposed(by: disposeBag)
        takeCodeBtn.rx.tap
            .subscribe(onNext : {[weak self] in self?.sendVerifiCode()})
            .disposed(by: disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    func register() {
        let alert : UIAlertController = UIAlertController(title: "注册", message: "注册成功", preferredStyle: .alert)
        let confim : UIAlertAction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confim)
        self.present(alert, animated: true, completion: nil)
    }
    func sendVerifiCode()  {
        let alert : UIAlertController = UIAlertController(title: "发送验证码", message: "验证码发送成功", preferredStyle: .alert)
        let confim : UIAlertAction = UIAlertAction(title: "确定", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confim)
        self.present(alert, animated: true, completion: nil)
    }
}
