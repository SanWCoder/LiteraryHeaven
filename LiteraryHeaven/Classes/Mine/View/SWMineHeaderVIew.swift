//
//  SWMineHeaderVIew.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/25.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

protocol headerProtocol: NSObjectProtocol {
    func headerAction(sender:AnyObject)
}

class SWMineHeaderVIew: UIView {
    
    var iconImageBtn : UIButton! // 头像
    var sexImage : UIImageView! // 性别
    var nameBtn : UIButton! // 名称和登录
    weak var delegate : headerProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
        backgroundColor = kColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func createSubViews()  {
        iconImageBtn = UIButton(type: .custom)
        iconImageBtn.setImage(UIImage(named:"photo"), for: .normal)
        
        sexImage = UIImageView(image: UIImage(named: "female"))
        
        nameBtn = UIButton(type: .custom)
        nameBtn.setTitle("登录", for: .normal)
        nameBtn.setImage(UIImage(named:"ple"), for: .selected)
        nameBtn.titleLabel?.font = kFont2
        nameBtn.setTitleColor(kColor11, for: .normal)
        nameBtn.addTarget(self, action: #selector(addData(sender:)), for: .touchUpInside)
        addSubview(iconImageBtn)
        addSubview(sexImage)
        addSubview(nameBtn)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // addData
        addLayout()
    }
}
extension SWMineHeaderVIew{
    
    func addData(sender : UIButton) -> Void {
        print(123)
        delegate?.headerAction(sender: sender)
    }
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
    }
    fileprivate func addLayout() -> Void {
        let width : CGFloat = 60.0
        sexImage.isHidden = true
        
        iconImageBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(kLeftMargin)
            make.width.height.equalTo(width)
            make.centerY.equalTo(self)
        }
        iconImageBtn.layer.cornerRadius = width / 2.0
        iconImageBtn.layer.masksToBounds = true
        
        nameBtn.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageBtn.snp.right).offset(kLeftMargin * 3)
            make.width.equalTo(120)
            make.height.equalTo(30)
            make.centerY.equalTo(self)
        }
        nameBtn.layer.cornerRadius = kRadius
        nameBtn.layer.masksToBounds = true
        nameBtn.layer.borderColor = kColor1.cgColor
        nameBtn.layer.borderWidth = 1
    }
}
