//
//  RefreshViewModel.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/6.
//  Copyright © 2018年 white. All rights reserved.
//

import RxSwift
import RxCocoa

class RefreshViewModel {
    
    //表格数据序列
    let tableData = BehaviorRelay<[String]>(value: [])
    
    //停止头部刷新状态
    let endHeaderRefreshing: Driver<Bool>
    
    //停止尾部刷新状态
    let endFooterRefreshing: Driver<Bool>
    
    //ViewModel初始化（根据输入实现对应的输出）
    init(input: (
        headerRefresh: Driver<Void>,
        footerRefresh: Driver<Void> ),
         dependency: (
        disposeBag:DisposeBag,
        networkService: NetworkService )) {
        
        //下拉结果序列
        let headerRefreshData = input.headerRefresh
            .startWith(()) //初始化时会先自动加载一次数据
            .flatMapLatest {
                return dependency.networkService.getRandomResult()
        }
        
        //上拉结果序列
        let footerRefreshData = input.footerRefresh
            .flatMapLatest {
                return dependency.networkService.getRandomResult()
        }
        
        //生成停止头部刷新状态序列
        self.endHeaderRefreshing = headerRefreshData.map{ _ in true }
        
        //生成停止尾部刷新状态序列
        self.endFooterRefreshing = footerRefreshData.map{ _ in true }
        
        //下拉刷新时，直接将查询到的结果替换原数据
        headerRefreshData.drive(onNext: { items in
            self.tableData.accept(items)
        })
            .disposed(by: dependency.disposeBag)
        
        //上拉加载时，将查询到的结果拼接到原数据底部
        footerRefreshData.drive(onNext: { items in
            self.tableData.accept(self.tableData.value + items )
        })
            .disposed(by: dependency.disposeBag)
    }
}

