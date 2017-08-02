//
//  SWSlideMenuModel.swift
//  LiteraryHeaven
//
//  Created by SanW on 2017/7/31.
//  Copyright © 2017年 ONON. All rights reserved.
//

import UIKit

class SWSlideMenuModel: NSObject {
    var itemId : Int!
    var itemTitle : String?
    var isSelected : Bool = false
    
    override init() {
        super.init()
    }
}
class SWSlideMenuRootModel: SWSlideMenuModel {
   var subItems : [SWSlideMenuSubModel]!
    override init() {
        super.init()
        subItems = [SWSlideMenuSubModel]()
    }
}
class SWSlideMenuSubModel: SWSlideMenuModel {
    var itemViewController : UIViewController?
    override init() {
        super.init()
    }
}
