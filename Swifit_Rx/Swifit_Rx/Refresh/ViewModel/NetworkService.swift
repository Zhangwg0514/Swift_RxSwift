//
//  NetworkService.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/6.
//  Copyright © 2018年 white. All rights reserved.
//

import RxSwift
import RxCocoa

class NetworkService: NSObject {
    // driver 方法只能在 Driver 序列中使用 , Driver 有以下特点
    // 1. Driver 序列不允许发出 error;
    // 2. Driver 在主线程中监听;
    // 3. Driver 共享事件流;
    
    //获取随机数据
    func getRandomResult() -> Driver<[String]> {
        print("正在请求数据......")
        let items = (0 ..< 15).map {_ in
            "随机数据\(Int(arc4random()))"
        }
        let observable = Observable.just(items)
        return observable
            .delay(1, scheduler: MainScheduler.instance)
            .asDriver(onErrorDriveWith: Driver.empty())
    }
}
