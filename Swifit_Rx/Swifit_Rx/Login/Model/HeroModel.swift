//
//  HeroModel.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/5.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit

class HeroModel: NSObject {
    var name: String
    var desc: String
    var icon: String
    
    init(name: String, desc: String, icon: String) {
        self.name = name
        self.desc = desc
        self.icon = icon
    }
    
}
