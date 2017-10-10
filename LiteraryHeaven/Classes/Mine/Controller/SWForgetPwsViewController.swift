//
//  SWForgetPwsViewController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/8/18.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SVProgressHUD
class SWForgetPwsViewController: UIViewController {
    let disposeBag = DisposeBag()
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var remindPwsLab: UILabel!
    @IBOutlet weak var conmmitBtn: UIButton!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var takeCodeBtn: UIButton!
    @IBOutlet weak var passAgainTF: UITextField!
    @IBOutlet weak var verifiCodeTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "忘记密码"
        topContraint.constant = topContraint.constant + kNavHeight
        takeCodeBtn.layer.cornerRadius = kRadius
        takeCodeBtn.layer.masksToBounds = true
        conmmitBtn.layer.cornerRadius = kRadius
        conmmitBtn.layer.masksToBounds = true
        phoneTF.keyboardType = .phonePad
        verifiCodeTF.keyboardType = .numberPad
        
        // 使用Rx
        let phoneValide = phoneTF.rx.text.orEmpty
            .map({$0.characters.count >= 11})
        let verifiValide = verifiCodeTF.rx.text.orEmpty
            .map({$0.characters.count >= 4})
        let passwordValide = passwordTF.rx.text.orEmpty
            .map({$0.characters.count >= 6 && $0.characters.count <= 16})
        let pasAgainValide = passAgainTF.rx.text.orEmpty
            .map({$0.characters.count >= 6 && $0.characters.count <= 16})
        phoneValide
            .bind(to: takeCodeBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        pasAgainValide
            .bind(to: remindPwsLab.rx.isHidden)
            .disposed(by: disposeBag)
        
        let allVelide = Observable.combineLatest(phoneValide,verifiValide,passwordValide,pasAgainValide){$0 && $1 && $2 && $3}
        allVelide
            .bind(to: conmmitBtn.rx.isEnabled)
            .disposed(by: disposeBag)
        takeCodeBtn.rx.tap
            .subscribe(onNext : {[weak self] in self?.sendVerifiCode()})
            .disposed(by: disposeBag)
        conmmitBtn.rx.tap
            .subscribe(onNext : {[weak self] in self?.confimAction()})
            .disposed(by: disposeBag)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    func confimAction() {
        SWMineViewModel.forgetPassword(phone: phoneTF.text!, password: passwordTF.text!, verify: verifiCodeTF.text!) { (response) in
            guard response["code"] as! Int != 400 else{
                SVProgressHUD .showError(withStatus:response["msg"] as! String)
                return
            }
            let code : Int = response["code"] as! Int
            guard code == 0 else{
                SVProgressHUD .showError(withStatus:response["msg"] as! String )
                return
            }
            SVProgressHUD .showSuccess(withStatus: "修改成功")
            self.navigationController?.popViewController(animated: true)
        }
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
