//
//  SWSlideMenuView.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/28.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit
enum menuCellType {
    case nomal /// 一级菜单
    case subMenu /// 二级菜单
}

class SWSlideMenuView : UIView {
    /// 一级菜单试图高度
    var titleViewHeight : CGFloat!{
        didSet{
            updateFrame()
        }
    }
    /// 二级菜单试图高度
    var subTitleViewHeight : CGFloat!{
        didSet{
            updateFrame()
        }
    }
    /// 一级菜单cell间隔
    var titleViewMargin : CGFloat!{
        didSet{
            updateFrame()
        }
    }
    /// 二级菜单cell间隔
    var subTitleViewMargin : CGFloat!{
        didSet{
            updateFrame()
        }
    }
    var bottomHeight : CGFloat = 10 /// 底部线距离二级菜单距离
    var currentIndex : Int = 0 /// 当前点击的一级标题位置
    var currentSubIndex : Int = 0 /// 当前点击的二级标题位置
    /// 底部分隔线
    lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = kColor4
        return bottomLine
    }()
    /// 一级菜单试图
    lazy var titleContentView : UICollectionView = {
        let flowLayout = SWSlideViewFlowLayout()
        let titleContentView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        titleContentView.backgroundColor = kColor
        titleContentView.showsVerticalScrollIndicator = false
        titleContentView.showsHorizontalScrollIndicator = false
        titleContentView.register(SWSlideMenuCell.self, forCellWithReuseIdentifier: "SWSlideMenuCell")
        titleContentView.delegate = self
        titleContentView.dataSource = self
        return titleContentView
    }()
    /// 二级菜单试图
    lazy var subTitleContentView : UICollectionView = {
        let flowLayout = SWSlideViewFlowLayout()
        let subTitleContentView = UICollectionView(frame: CGRect(), collectionViewLayout: flowLayout)
        subTitleContentView.backgroundColor = kColor
        subTitleContentView.showsVerticalScrollIndicator = false
        subTitleContentView.showsHorizontalScrollIndicator = false
        subTitleContentView.register(SWSlideMenuCell.self, forCellWithReuseIdentifier: "SWSlideMenuCell")
        subTitleContentView.delegate = self
        subTitleContentView.dataSource = self
        return subTitleContentView
    }()
    /// 数据源(监听数据赋值，更新collectView)
    var titleArrData : [SWSlideMenuRootModel]?{
            didSet{
                /// 更新cell布局
                updateCelllayout()
                /// 更新第一个控制器
                addFirstViewController()
                titleContentView.reloadData()
                subTitleContentView.reloadData()
            }
        }
    /// 初始化
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleViewHeight = 30
        subTitleViewHeight = 30
        titleViewMargin = 20
        subTitleViewMargin = 10
        addSubview(titleContentView)
        addSubview(subTitleContentView)
        addSubview(bottomLine)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// 更新试图frame
extension SWSlideMenuView{
    /// 更新视图布局
    func updateFrame() {
        titleContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(titleViewHeight)
            make.top.equalTo(self.snp.top)
        }
        subTitleContentView.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(subTitleViewHeight)
            make.top.equalTo(titleContentView.snp.bottom)
        }
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.height.equalTo(1)
        make.top.equalTo(subTitleContentView.snp.bottom).offset(bottomHeight)
        }
        if ((self.titleArrData?.count)! > 0) && ((self.titleArrData?[0].subItems.count)! > 0){
            let Vc = self.titleArrData?[0].subItems[0].itemViewController
            Vc?.view.frame = CGRect(x: 0, y: titleViewHeight + subTitleViewHeight + bottomHeight + 1, width: self.frame.size.width, height: self.frame.size.height - (titleViewHeight + subTitleViewHeight + bottomHeight + 1))
            self.addSubview((Vc?.view)!)
            /// 调整子视图
            for subView in (Vc?.view.subviews)! {
                if subView is UITableView {
                    subView.frame = CGRect(x: 0, y: 0, width: (Vc?.view.frame.size.width)!, height: (Vc?.view.frame.size.height)!)
                }
            }
        }
        titleContentView.reloadData()
        subTitleContentView.reloadData()
    }
    /// flowLayout 更新cell布局
    func updateCelllayout()  {
        let flowLayout = SWSlideViewFlowLayout()
        flowLayout.items = (self.titleArrData?.count)! > 0 ?self.titleArrData?[0].subItems : nil
        flowLayout.margin = self.subTitleViewMargin
        flowLayout.scrollDirection = .horizontal
        subTitleContentView.collectionViewLayout = flowLayout
        let titleFlowLayout = SWSlideViewFlowLayout()
        titleFlowLayout.items = self.titleArrData
        titleFlowLayout.margin = self.titleViewMargin
        titleFlowLayout.scrollDirection = .horizontal
        titleContentView.collectionViewLayout = titleFlowLayout
    }
    /// 更新第一个子控制器
    func addFirstViewController() {
        if ((self.titleArrData?.count)! > 0) && ((self.titleArrData?[0].subItems.count)! > 0){
            let Vc = self.titleArrData?[0].subItems[0].itemViewController
            Vc?.view.frame = CGRect(x: 0, y: titleViewHeight + subTitleViewHeight + bottomHeight + 1, width: self.frame.size.width, height: self.frame.size.height - (titleViewHeight + subTitleViewHeight + bottomHeight + 1))
            self.addSubview((Vc?.view)!)
            /// 调整子视图
            for subView in (Vc?.view.subviews)! {
                if subView is UITableView {
                    subView.frame = CGRect(x: 0, y: 0, width: (Vc?.view.frame.size.width)!, height: (Vc?.view.frame.size.height)!)
                }
            }
        }
    }
}
/// collectView的代理方法
extension SWSlideMenuView : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView === self.subTitleContentView {
            return (titleArrData?.count)! > currentIndex ?titleArrData![currentIndex].subItems.count : 0
        }
        else{
            return titleArrData!.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        var type : menuCellType = .nomal
        var slideMenuModel : SWSlideMenuModel?
        if collectionView === self.subTitleContentView {
            type = .subMenu
            slideMenuModel = titleArrData?[currentIndex].subItems[indexPath.item]
        }else{
            type = .nomal
            slideMenuModel = titleArrData?[indexPath.item]
        }
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "SWSlideMenuCell", for: indexPath)) as! SWSlideMenuCell
        cell.type = type
        cell.slideMenuModel = slideMenuModel
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView === self.titleContentView && indexPath.row == currentIndex {
            return
        }
        if collectionView === self.subTitleContentView && indexPath.row == currentSubIndex {
            return
        }
        updateSetting(indexPath: indexPath, collectionView: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 100, height: 30)
    }
    func updateSetting(indexPath : IndexPath,collectionView : UICollectionView) {
        
        if collectionView === self.titleContentView {
            let titleModel = titleArrData?[indexPath.row]
            titleModel?.isSelected = true
            
            let nomalTitleModel = titleArrData?[currentIndex]
            nomalTitleModel?.isSelected = false
            /// 移除旧视图
            let oldVc = titleArrData?[currentIndex].subItems[currentSubIndex].itemViewController
            oldVc?.view.removeFromSuperview()
            
            currentIndex = indexPath.item
            for (subIndex,item) in (titleArrData?[currentIndex].subItems.enumerated())! {
                if item.isSelected {
                   currentSubIndex = subIndex
                    break
                }
            }
            let newVc = titleArrData?[currentIndex].subItems[currentSubIndex].itemViewController
            newVc?.view.frame = CGRect(x: 0, y: titleViewHeight + subTitleViewHeight + bottomHeight + 1, width: self.frame.size.width, height: self.frame.size.height - (titleViewHeight + subTitleViewHeight + bottomHeight + 1))
            self.addSubview((newVc?.view)!)
            /// 调整子视图
            for subView in (newVc?.view.subviews)! {
                if subView is UITableView {
                    subView.frame = CGRect(x: 0, y: 0, width: (newVc?.view.frame.size.width)!, height: (newVc?.view.frame.size.height)!)
                }
            }
            let flowLayout = SWSlideViewFlowLayout()
            flowLayout.items = titleArrData?[currentIndex].subItems
            flowLayout.margin = subTitleViewMargin
            subTitleContentView.collectionViewLayout = flowLayout
            subTitleContentView.reloadData()
            titleContentView.reloadData()
        }
        else{
            /// 移除旧视图
            let oldVc = titleArrData?[currentIndex].subItems[currentSubIndex].itemViewController
            oldVc?.view.removeFromSuperview()
            let titleModel = titleArrData?[currentIndex].subItems[indexPath.row]
            titleModel?.isSelected = true
            
            let nomalTitleModel = titleArrData?[currentIndex].subItems[currentSubIndex]
            nomalTitleModel?.isSelected = false
            
            currentSubIndex = indexPath.row
            let newVc = titleArrData?[currentIndex].subItems[currentSubIndex].itemViewController
            newVc?.view.frame = CGRect(x: 0, y: titleViewHeight + subTitleViewHeight + bottomHeight + 1, width: self.frame.size.width, height: self.frame.size.height - (titleViewHeight + subTitleViewHeight + bottomHeight + 1))
            self.addSubview((newVc?.view)!)
            /// 调整子视图
            for subView in (newVc?.view.subviews)! {
                if subView is UITableView {
                    subView.frame = CGRect(x: 0, y: 0, width: (newVc?.view.frame.size.width)!, height: (newVc?.view.frame.size.height)!)
                }
            }
            subTitleContentView.reloadData()
            titleContentView.reloadData()
        }
    }
}
/// cell
class SWSlideMenuCell: UICollectionViewCell {
    
    var nomalColor : UIColor = kColor12
    let nomalFont : UIFont = kFont3
    let bgColor : UIColor = kColor4
    var type : menuCellType = .nomal
    
    var slideMenuModel : SWSlideMenuModel?{
        didSet{
            /// 赋值
            addData()
            addLayout()
        }
    }
    lazy var itemBtn : UIButton = {
        let itemBtn = UIButton(type: .custom)
        itemBtn.setTitleColor(self.nomalColor, for: .normal)
        itemBtn.setTitleColor(kColor1, for: .selected)
        itemBtn.titleLabel?.font = kFont3
        itemBtn.isUserInteractionEnabled = false
        return itemBtn
    }()
    lazy var bottomLine : UIView = {
        let bottomLine = UIView()
        bottomLine.backgroundColor = kColor1
        return bottomLine
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        if type == .nomal {
            nomalColor = kColor12
        }
        else{
            nomalColor = kColor7
        }
        contentView.addSubview(itemBtn)
        contentView.addSubview(bottomLine)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addData() {
        itemBtn.setTitle(slideMenuModel?.itemTitle, for: .normal)
    }
    func addLayout()  {

        bottomLine.isHidden = (slideMenuModel?.isSelected)!&&slideMenuModel is SWSlideMenuRootModel ? false : true
        itemBtn.isSelected = (slideMenuModel?.isSelected)! 
        bottomLine.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView)
            make.height.equalTo(type == .nomal ? 3 : 0)
        }
        itemBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.contentView)
            make.right.equalTo(self.contentView)
            make.top.equalTo(self.contentView).offset(type == .nomal ? 3 : 6)
            make.bottom.equalTo(type == .nomal ? bottomLine.snp.top : self.contentView).offset(type == .nomal ? -5 : -4)
        }
        itemBtn.backgroundColor = type == .nomal ? kColor : kColor4
        itemBtn.layer.cornerRadius = kRadius
        itemBtn.layer.masksToBounds = true
    }
}
/// 自定义flowLayout
class SWSlideViewFlowLayout: UICollectionViewFlowLayout {
    var items : [SWSlideMenuModel]? /// 需要计算的数据模型
    var margin : CGFloat = 20 /// item之间的间隔
    let firstItemMargin : CGFloat = 18 /// 第一个Item距离父视图间隔
    private var attributes :[UICollectionViewLayoutAttributes]?
    
    override func prepare() {
        super.prepare()
        attributes = [UICollectionViewLayoutAttributes]()
        if items == nil {
            return
        }
        /// 计算每个item的位置
        for (index,slideMenuModel) in items!.enumerated() {
            let title = NSString(string: slideMenuModel.itemTitle!)
            let size = title.boundingRect(with: CGSize(width: 100, height: 20), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:kFont3], context: nil).size
            let atts = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item:index , section: 0))
            var width : CGFloat = 0
            if attributes?.count != 0 {
                width = (attributes?[0].frame.size.width)!
            }
            atts.frame = CGRect(x: firstItemMargin + (margin + width) * CGFloat(index), y: 0, width: size.width + 10, height: size.height + 14)
            attributes?.append(atts)
        }
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
}

