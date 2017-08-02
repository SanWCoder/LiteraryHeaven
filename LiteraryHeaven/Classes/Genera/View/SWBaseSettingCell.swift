//
//  SWBaseSettingCell.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/21.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWBaseSettingCell: UITableViewCell {
    
    lazy var subImageTextBtn : UIButton = {
        var subImageTextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        subImageTextBtn.titleLabel?.font = kFont3
        subImageTextBtn.setTitleColor(kColor12, for:.normal)
        return subImageTextBtn
    }()
    lazy var subTitleLab : UILabel = {
        var subTitleLab = UILabel(frame: CGRect(x: 0, y: 0, width: 10, height: 22))
        subTitleLab.font = kFont3
        subTitleLab.textColor = kColor12
        return subTitleLab
    }()
    lazy var subImage : UIImageView = {
        var subImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 18, height: 22))
        subImage.image = UIImage(named: "more")
        return subImage
    }()
    lazy var subSwitch : UISwitch = {
        var subSwitch = UISwitch(frame: CGRect(x: 0, y: 0, width: 18, height: 22))
        return subSwitch
    }()
    lazy var subArrowTextBtn : UIButton = {
        var subArrowTextBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 22))
        subArrowTextBtn.titleLabel?.font = kFont3
        subArrowTextBtn.setTitleColor(kColor12, for:.normal)
        return subArrowTextBtn
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:reuseIdentifier)
        self.selectionStyle = .none
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func baseCell (tableView:UITableView) -> SWBaseSettingCell?{
        let identifier = "SWHomePageCell"
        var cell : SWBaseSettingCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? SWBaseSettingCell
        if cell == nil {
            cell = SWBaseSettingCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    var baseModel : SWBaseSettingModel? {
        didSet{
            addData()
            addTailView()
        }
    }
}
extension SWBaseSettingCell{
    func addData() {
        if baseModel?.icon != nil {
            imageView?.image = UIImage(named: (baseModel?.icon)!)
        }
        textLabel?.text = baseModel?.title
    }
    func addTailView() {
        if baseModel is SWBaseSettingImage {
            accessoryView = self.subImage
            let imageModel = baseModel as? SWBaseSettingImage
            subImage.image = UIImage(named: (imageModel?.subImage)!)
        }
        else if baseModel is SWBaseSettingText{
            let textModel = baseModel as? SWBaseSettingText
            subTitleLab.text = textModel?.subTitle
            let str = textModel?.subTitle
            let size = str?.sizeWithString(font: kFont3, width: 100)
            subTitleLab.frame.size = size!
            subTitleLab.adjustsFontSizeToFitWidth = true
            accessoryView = self.subTitleLab
        }
        else if baseModel is SWBaseSettingSwitch{
            accessoryView = self.subSwitch
            //            let textModel = baseModel as? SWBaseSettingSwitch
        }
        else if baseModel is SWBaseSettingImageText{
            accessoryView = self.subImageTextBtn
            let textImageModel = baseModel as? SWBaseSettingImageText
            let size = textImageModel?.subTitle?.sizeWithString(font: kFont3, width: 150)
            subImageTextBtn.frame.size = CGSize(width: (size?.width)! + 20, height: (size?.height)!)
            subImageTextBtn.setImage(UIImage(named: (textImageModel?.subImage)!), for: .normal)
            subImageTextBtn.setTitle(textImageModel?.subTitle, for: .normal)
        }
        else if baseModel is SWBaseSettingTextImage{
            accessoryView = self.subArrowTextBtn
            let textImageModel = baseModel as? SWBaseSettingTextImage
            let size = textImageModel?.subTitle?.sizeWithString(font: kFont3, width: 150)
            subArrowTextBtn.frame.size = CGSize(width: (size?.width)! + 30, height: (size?.height)!)
            subArrowTextBtn.setImage(UIImage(named: (textImageModel?.subImage)!), for: .normal)
            subArrowTextBtn.setTitle(textImageModel?.subTitle, for: .normal)
            subArrowTextBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (size?.width)! + 10, 0, 0)
            subArrowTextBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0)
        }
        else{
            accessoryView = nil
        }
    }
}
extension String{
    func sizeWithString(font:UIFont,width:CGFloat) -> CGSize {
        let statusLabelText: NSString = NSString.init(string: self)
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize
    }
}
