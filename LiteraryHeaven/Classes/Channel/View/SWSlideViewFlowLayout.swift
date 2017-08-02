//
//  SWSlideViewFlowLayout.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/31.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWSlideViewFlowLayout: UICollectionViewFlowLayout {
    var items : [SWSlideMenuModel]? /// 需要计算的数据模型
    var margin : CGFloat = 20 /// item之间的间隔
    let firstItemMargin : CGFloat = 18 /// 第一个Item距离父视图间隔
    private var attributes :[UICollectionViewLayoutAttributes]?
    
    override func prepare() {
        super.prepare()
        attributes = [UICollectionViewLayoutAttributes]()
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
