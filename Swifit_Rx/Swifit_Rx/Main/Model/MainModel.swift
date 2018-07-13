//
//  MainModel.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/6.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit

// Swfit viewModel 和 model 一般都是用结构体来构建数据模型

struct  MainModel{
    var name: String
    var desc: String
    var icon: String
    var className: String
    
    
    init(name: String, desc: String, icon: String,className: String) {
        self.name = name
        self.desc = desc
        self.icon = icon
        self.className = className
    }
}
