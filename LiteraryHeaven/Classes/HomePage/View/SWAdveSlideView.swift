//
//  SWAdveSlideView.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/20.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

protocol clickImageProtocal : NSObjectProtocol{
    func clickImageIndex(indexPath : IndexPath)
}
/// 广告轮播试图
class SWAdveSlideView: UIView {
    var timer : Timer?
    var dataSource : [String]? {
        didSet{
            pageController.numberOfPages = (dataSource?.count)!
            collectView.reloadData()
            if (dataSource?.count)! > 0 {
                fireTimer()
            }
        }
    }
    lazy var collectView : UICollectionView = {
        let height : CGFloat = 180
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: self.frame.size.width, height: height)
        var collectView : UICollectionView = UICollectionView(frame: CGRect(x : 0,y : 0,width:self.frame.size.width,height:height), collectionViewLayout:layout )
        collectView.delegate = self
        collectView.dataSource = self
        collectView.register(SWAdvSlideCollectionCell.self, forCellWithReuseIdentifier: "SWAdvSlideCollectionCell")
        collectView.isPagingEnabled = true
        collectView.showsVerticalScrollIndicator = false
        collectView.showsHorizontalScrollIndicator = false
        collectView.bounces = false
        collectView.backgroundColor = kColor4
        return collectView
    }()
    lazy var pageController : UIPageControl = {
        var pageController : UIPageControl = UIPageControl(frame: CGRect(x: (self.center.x - 100 / 2 ), y: self.collectView.frame.size.height - 40, width: 100, height: 30))
        pageController.pageIndicatorTintColor = kColor
        pageController.currentPageIndicatorTintColor = kColor1
        pageController.hidesForSinglePage = true
        pageController.addTarget(self, action: #selector(pageCotrolAction(pageController:)), for: .valueChanged)
        return pageController
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectView)
        addSubview(pageController)
        dataSource = [String]()
        createBottomView()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
/// collecView代理方法
extension SWAdveSlideView : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource!.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = SWAdvSlideCollectionCell.advCell(collectView: collectView, indexPath: indexPath)
        cell.imageStringData = dataSource?[indexPath.item]
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        invaliTimer()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        pageController.currentPage = Int(page)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.fireTimer()
        }
    }
}
/// 定时器
extension SWAdveSlideView{
    func fireTimer() {
        if timer == nil {
            self.timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollImage(timer:)), userInfo: nil, repeats: true)
            self.timer?.fire()
        }
    }
    func invaliTimer() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    func scrollImage(timer : Timer) -> Void {
        var currentPage = pageController.currentPage
        currentPage += 1
        if currentPage == (dataSource?.count)! {
            currentPage = 0
        }
        collectView.setContentOffset(CGPoint(x : CGFloat(currentPage) * collectView.frame.size.width,y : 0), animated: true)
        pageController.currentPage = currentPage
    }
}
/// pageController事件
extension SWAdveSlideView{
    func pageCotrolAction(pageController : UIPageControl) {
        invaliTimer()
        collectView.setContentOffset(CGPoint(x : CGFloat(pageController.currentPage) * collectView.frame.size.width,y : 0), animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.fireTimer()
        }
    }
}
/// 自定义collecViewCell类
class SWAdvSlideCollectionCell: UICollectionViewCell {
    /// 数据源
    var imageStringData : String? {
        didSet{
            addData()
        }
    }
    /// 子控件
    lazy var advImage : UIImageView = {
        var advImage : UIImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        return advImage
    }()
    /// 重写init(frame: CGRect)
    override init(frame: CGRect) {
        super.init(frame: frame)
        // 创建cell
        addSubview(advImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// 子控件赋值
    func addData()  {
        if (imageStringData?.isEmpty)! {
            return
        }
        advImage.kf.setImage(with: URL(string: imageStringData!))
    }
    /// 类方法快速创建cell
    class func advCell(collectView : UICollectionView,indexPath : IndexPath) -> SWAdvSlideCollectionCell {
        let cell : SWAdvSlideCollectionCell = collectView.dequeueReusableCell(withReuseIdentifier: "SWAdvSlideCollectionCell", for: indexPath) as! SWAdvSlideCollectionCell
        return cell
    }
}

extension SWAdveSlideView
{
    fileprivate func createBottomView(){
        let height : CGFloat = 90
        let btnW : CGFloat = 100
        let btnH : CGFloat = 50
        let topH : CGFloat = (height - btnH) / 2
        let margin = (self.frame.size.width - (btnW * 3)) / 4
        // 100 * 50
        let contentView = UIView(frame: CGRect(x: 0, y: collectView.frame.size.height, width: self.frame.size.width, height: height))
        contentView.backgroundColor = kColor
        addSubview(contentView)
        
        let subViews : [String] = ["click_list","comment_list","article_list"]
        for (index,view) in subViews.enumerated() {
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: margin + (btnW + margin) * CGFloat(index), y: topH, width: btnW, height: btnH)
            btn.setImage(UIImage(named:view), for: .normal)
            btn.tag = index + 1
            contentView.addSubview(btn)
        }
    }
}

