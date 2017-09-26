//
//  SWUpdateUserInfoController.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/9/26.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SVProgressHUD

class SWUpdateUserInfoController: UIViewController {
    var isUpdateNickName : Bool = true
    
    @IBOutlet weak var nickNameTF: UITextField!
    
    @IBOutlet weak var confirmBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nickNameTF.placeholder = isUpdateNickName ? SWCommonTool.userInfo()?.nickName : SWCommonTool.userInfo()?.info
        confirmBtn.layer.cornerRadius = kRadius
        confirmBtn.layer.masksToBounds = true
    }

    @IBAction func confirmAction(_ sender: UIButton) {
        guard !(nickNameTF.text?.isEmpty)! else {
            SVProgressHUD.showError(withStatus: isUpdateNickName ? "昵称不能为空" : "简介不能为空")
            return
        }
        if isUpdateNickName {
            
            SWMineViewModel.updateInfo(nickName: nickNameTF.text!, header: "", sex: "", info: "") { (response) in
                let userInfo = SWCommonTool.userInfo()
                userInfo?.nickName = self.nickNameTF.text
                SWCommonTool.saveUserInfo(userModel: userInfo!)
                NotificationCenter.default.post(name: NSNotification.Name(kLoginSuccessNC), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }else{
            SWMineViewModel.updateInfo(nickName: "", header: "", sex: "", info: nickNameTF.text!) { (response) in
                let userInfo = SWCommonTool.userInfo()
                userInfo?.info = self.nickNameTF.text
                SWCommonTool.saveUserInfo(userModel: userInfo!)
                NotificationCenter.default.post(name: NSNotification.Name(kLoginSuccessNC), object: nil)
                self.navigationController?.popViewController(animated: true)
        }
    }
    //        SWMineViewModel.updateInfo(nickName: "wenwenwei", header: "", sex: "", info: "") { (response) in
    //            print(response)
    //        }
    //        SWMineViewModel.updateInfo(nickName: "", header: "http://a.png", sex: "", info: "") { (response) in
    //            print(response)
    //        }
    //        SWMineViewModel.updateInfo(nickName: "", header: "", sex: "1", info: "") { (response) in
    //            print(response)
    //        }

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}
