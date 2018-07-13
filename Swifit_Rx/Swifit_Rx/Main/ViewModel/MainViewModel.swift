//
//  MainViewModel.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/6.
//  Copyright © 2018年 white. All rights reserved.
// http://www.hangge.com/blog/cache/detail_1922.html

import UIKit
import RxCocoa
import RxSwift

struct MainViewModel {
    // Observable 可观察序列 。 作用就是异步产生一系列的 Event (事件)
    // Observable<T> 对象会随着时间推移不定期的发送 event(element:T)
    // 这些 event 还可以携带数据 ，它的泛型<T>就是用来指定这个 event 携带的数据类型
    // 有了可观察序列 , 我们还需要有一个 Observer (订阅者) 来的订阅它 ， 这样这个订阅者才能收到 Observable<T> 不时发出的 event
    // Event 是一个枚举 ， 也就是说一个 Observable 是一个可以发出 3 种不同类型的 Event 事件
    // next: 可以携带 <T> 的事件
    // error: 可以携带具体的错误内容 , 一旦 Observable 发出了 error 事件 , 则这个 Observable 就等于终止了 ， 以后它不会再发出 event 事件了
    // completed: Observable 发出的时间正常结束了 , 一旦 Observable 发出了 error 事件 , 则这个 Observable 就等于终止了 ， 以后它不会再发出 event 事件了
    
    // 创建 Observable 序列
    // 1. just() 方法 --> （1）传入一个默认的值来初始化 （2）下面样例我们显式地标注出了 observable 的类型为 Observable<Int>，即指定了这个 Observable 所发出的事件携带的数据类型必须是 Int 类型的。
    // let observable = Observable<Int>.just(5)
    
    let data = Observable.just(loadMainPlist())
    
}

func loadMainPlist() -> Array<MainModel> {
    let mainPlistPath = Bundle.main.path(forResource: "main", ofType: "plist")
    let data = NSArray(contentsOfFile: mainPlistPath!) as! Array<[String : String]>
    
    var dataSource = [MainModel]()
    
    for dic in data {
        let mainModel = MainModel(name: dic["name"]!, desc: dic["desc"]!, icon: dic["icon"]!, className: dic["className"]!)
        dataSource.append(mainModel)
    }
    return dataSource
}
