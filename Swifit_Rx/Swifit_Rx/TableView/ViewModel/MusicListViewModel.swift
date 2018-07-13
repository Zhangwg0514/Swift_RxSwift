//
//  MusicListViewModel.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/13.
//  Copyright © 2018年 white. All rights reserved.
//

import RxSwift

struct MusicListViewModel {
    //创建 Observable 序列
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
        Music(name: "祝福", singer: "张学友")
        ])
}
