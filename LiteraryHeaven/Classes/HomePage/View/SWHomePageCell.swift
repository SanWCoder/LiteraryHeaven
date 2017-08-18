//
//  SWHomePageCell.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/20.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher
class SWHomePageCell: UITableViewCell {
    // 懒加载子视图
    lazy var titleLab : UILabel = {
        let titleLab = UILabel()
        titleLab.font = kFont3
        titleLab.numberOfLines = 2
        titleLab.textColor = kColor11
        return titleLab
    }()
    
    lazy var nickLab : UILabel = {
        let nickLab = UILabel()
        nickLab.font = kFont4
        nickLab.textColor = kColor12
        return nickLab
    }()
    
    lazy var clickLab :UILabel = {
        let clickLab = UILabel()
        clickLab.font = kFont4
        clickLab.textColor = kColor7
        return clickLab
    }()
    lazy var iconImage : UIImageView = {
        let iconImage = UIImageView()
        return iconImage
    }()
    lazy var articleImage : UIImageView = {
        let articleImage = UIImageView()
        return articleImage
    }()
    lazy var bgView : UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        return bgView
    }()
    lazy var liveBgView : UIView = {
        let liveBgView = UIView()
        liveBgView.backgroundColor = UIColor.clear
        liveBgView.layer.borderColor = kColor8.cgColor
        liveBgView.layer.borderWidth = 1
        return liveBgView
    }()
    lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = kColor3
        return lineView
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        // 创建子视图
        createSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    class func homePageCell (tableView:UITableView) -> SWHomePageCell?{
        let identifier = "SWHomePageCell"
        var cell : SWHomePageCell? = tableView.dequeueReusableCell(withIdentifier: identifier) as? SWHomePageCell
        if cell == nil {
            cell = SWHomePageCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell
    }
    /// 拿到数据源给相应cell赋值布局
    var articleMode : SWArticleModel? {
        didSet{
            addData()
            addLayout()
        }
    }
}
/// 添加子控件
extension SWHomePageCell {
    fileprivate func createSubView() {
        contentView.addSubview(articleImage)
        contentView.addSubview(bgView)
        contentView.addSubview(liveBgView)
        contentView.addSubview(titleLab)
        contentView.addSubview(nickLab)
        contentView.addSubview(iconImage)
        contentView.addSubview(clickLab)
        contentView.addSubview(lineView)
    }
}
/// 赋值
extension SWHomePageCell {
    fileprivate func addData() {
        titleLab.text = articleMode?.articleTitle
        iconImage.image = UIImage(named: "photo")
        
        iconImage.kf.setImage(with: URL(string: "http://c.hiphotos.baidu.com/zhidao/pic/item/d788d43f8794a4c22fe6ab9408f41bd5ac6e3943.jpg"), placeholder: UIImage(named: "photo"), options: [.targetCache(.default)], progressBlock: { (reciveSize, totalSize) in
            
        }) { (image, error, cacheType, url) in
            
        }
        //
        if ((articleMode?.articleImage) != nil) {
            articleImage.kf.setImage(with: URL(string: (articleMode?.articleImage)!))
        }
        else{
            articleImage.image = UIImage(named: "wyh")
        }
        nickLab.text = articleMode?.authorNick
        clickLab.text = articleMode?.clickCount
    }
}
/// 布局
extension SWHomePageCell {
    fileprivate func addLayout() {
        let imageW : CGFloat = 100
        let imageH : CGFloat = 75
        let margin : CGFloat = 12
        let iconW : CGFloat = 30
        let topH : CGFloat = 75
        if (articleMode?.isRecommend)! == false {
            clickLab.isHidden = false
            bgView.isHidden = true
            liveBgView.isHidden = true
            articleImage.snp.remakeConstraints { (make) in
                make.right.equalTo(contentView.snp.right).offset(-margin)
                make.width.equalTo(imageW)
                make.height.equalTo(imageH)
                make.centerY.equalTo(contentView)
            }
            titleLab.snp.remakeConstraints { (make) in
                make.left.equalTo(contentView).offset(margin)
                make.top.equalTo(articleImage)
                make.right.equalTo(articleImage.snp.left).offset(-margin)
            }
            iconImage.snp.remakeConstraints { (make) in
                make.left.equalTo(titleLab)
                make.top.equalTo(titleLab.snp.bottom).offset(8)
                make.width.height.equalTo(iconW)
            }
            nickLab.snp.remakeConstraints { (make) in
                
                make.left.equalTo(iconImage.snp.right).offset(margin)
                make.centerY.equalTo(iconImage)
            }
            clickLab.snp.remakeConstraints { (make) in
                make.left.equalTo(nickLab.snp.right).offset(margin)
                make.centerY.equalTo(nickLab)
            }
        }
        else{
            clickLab.isHidden = true
            bgView.isHidden = false
            liveBgView.isHidden = false
            articleImage.snp.remakeConstraints({ (make) in
                make.left.equalTo(contentView).offset(kLeftMargin)
                make.right.equalTo(contentView).offset(-kLeftMargin)
                make.height.equalTo(contentView)
            })
            bgView.snp.remakeConstraints({ (make) in
                make.width.equalTo(contentView.frame.size.width - topH)
                make.height.equalTo(imageW)
                make.centerY.equalTo(contentView)
                make.centerX.equalTo(contentView)
            })
            liveBgView.snp.remakeConstraints({ (make) in
                make.left.equalTo(bgView).offset(8)
                make.right.equalTo(bgView).offset(-8)
                make.top.equalTo(bgView).offset(8)
                make.bottom.equalTo(bgView).offset(-8)
            })
            titleLab.snp.remakeConstraints({ (make) in
                make.left.equalTo(liveBgView).offset(8)
                make.right.equalTo(liveBgView).offset(-8)
                make.top.equalTo(liveBgView).offset(8)
            })
            iconImage.snp.remakeConstraints { (make) in
                make.left.equalTo(titleLab)
                make.top.equalTo(titleLab.snp.bottom).offset(8)
                make.width.height.equalTo(iconW)
            }
            nickLab.snp.remakeConstraints { (make) in
                
                make.left.equalTo(iconImage.snp.right).offset(margin)
                make.centerY.equalTo(iconImage)
            }
        }
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).offset(-1)
            make.height.equalTo(1)
        }
        iconImage.layer.cornerRadius = iconW / 2
        iconImage.layer.masksToBounds = true
    }
}
class SWHomaPageSectionHeadView: UITableViewHeaderFooterView {
    enum sectionHeadType {
        case nomal
        case recommend
    }
    lazy var titleBtn : UIButton = {
        let titleBtn = UIButton(type: .custom)
        titleBtn.setImage(UIImage(named:"home_category"), for: .normal)
        titleBtn.titleLabel?.font = kFont3
        titleBtn.setTitleColor(kColor8, for: .normal)
        return titleBtn
    }()
    lazy var moreBtn : UIButton = {
        let moreBtn = UIButton(type: .custom)
        moreBtn.setImage(UIImage(named:"more"), for: .normal)
        moreBtn.setTitle("更多", for: .normal)
        moreBtn.titleLabel?.font = kFont4
        moreBtn.setTitleColor(kColor7, for: .normal)
        return moreBtn
    }()
    lazy var lineView : UIView = {
        let lineView = UIView()
        lineView.backgroundColor = kColor3
        return lineView
    }()
    var sectionTitle : String?{
        didSet{
            addData()
            addLayout()
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        // 创建子控件
        contentView.addSubview(titleBtn)
        contentView.addSubview(moreBtn)
        contentView.addSubview(lineView)
        contentView.backgroundColor = kColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addData()  {
        titleBtn.setTitle(sectionTitle, for: .normal)
    }
    func addLayout() {
        titleBtn.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(kLeftMargin)
            make.centerY.equalTo(contentView)
        }
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-kLeftMargin)
            make.centerY.equalTo(contentView)
        }
        moreBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-kLeftMargin)
            make.centerY.equalTo(contentView)
        }
        moreBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -30, bottom: 0, right: 0)
        moreBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: (moreBtn.titleLabel?.frame.size.width)!, bottom: 0, right: 0)
        
        lineView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(kLeftMargin)
            make.right.equalTo(contentView).offset(-kLeftMargin)
            make.height.equalTo(1)
            make.bottom.equalTo(contentView)
        }
    }
}
extension SWHomaPageSectionHeadView{
    class func sectionHeaderViewIdtifer(tableView : UITableView) -> SWHomaPageSectionHeadView?{
        let identifier = NSStringFromClass(self)
        
        var headerView : SWHomaPageSectionHeadView? = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? SWHomaPageSectionHeadView
        if headerView == nil {
            headerView = SWHomaPageSectionHeadView.init(reuseIdentifier: identifier)
        }
        return headerView
    }
}
