//
//  Refreshable.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/6.
//  Copyright © 2018年 white. All rights reserved.
//

import RxSwift
import RxCocoa

// create() 方法
// 该方法接受一个 block 形式的参数，任务是对每一个过来的订阅进行处理。

extension Reactive where Base : MJRefreshComponent {
    //正在刷新事件
    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            //因为一个订阅行为会有一个 Disposable 类型的返回值，所以在结尾一定要 returen 一个 Disposable
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    //停止刷新
    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
}
