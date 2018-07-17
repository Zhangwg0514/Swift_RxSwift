//
//  ObserverController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/17.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ObserverController: UIViewController {

    // 观察者的作用就是监听事件 ， 然后对这个事件作出响应。 任何响应时间的行为都是观察者
    lazy var showLabel1: UILabel = {
        let showLabel1 = UILabel()
        showLabel1.backgroundColor = UIColor.lightGray
        showLabel1.font = UIFont.systemFont(ofSize: 14.0)
        showLabel1.numberOfLines = 0
        showLabel1.text = "1. 在 subscribe 方法中创建观察者 (创建观察者最直接的放大就是在 Observable 的 subscribe 方法后面描述当事件发生时 ， 需要如何做出响应\n观察者就是由 onNext onError onCompleted 这些闭包构建出来的)"
        view.addSubview(showLabel1)
        return showLabel1
    }()
    
    lazy var showLabel2: UILabel = {
        let showLabel2 = UILabel()
        showLabel2.backgroundColor = UIColor.lightGray
        showLabel2.font = UIFont.systemFont(ofSize: 14.0)
        showLabel2.numberOfLines = 0
        view.addSubview(showLabel2)
        return showLabel2
    }()
    
    lazy var showLabel3: UILabel = {
        let showLabel3 = UILabel()
        showLabel3.backgroundColor = UIColor.lightGray
        showLabel3.font = UIFont.systemFont(ofSize: 14.0)
        showLabel3.numberOfLines = 0
        view.addSubview(showLabel3)
        return showLabel3
    }()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showLabel1.snp.makeConstraints { (make) in
            make.top.equalTo(84)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(100)
        }
        
        showLabel2.snp.makeConstraints { (make) in
            make.top.equalTo(showLabel1.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(100)
        }
        
        showLabel3.snp.makeConstraints { (make) in
            make.top.equalTo(showLabel2.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(120)
        }
        
        // 1. 在 subscribe 方法中创建观察者
        // 创建观察者最直接的放大就是在 Observable 的 subscribe 方法后面描述当事件发生时 ， 需要如何做出响应
        // 观察者就是由 onNext onError onCompleted 这些闭包构建出来的
        
        let observable = Observable.of("A","B","C")
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            
        }
        
        // 2. 在 bind 方法中创建观察者
        // 创建一个定时生成索引的 Observable 序列 , 并将索引数不断显示在 Lable 标签上
        
        // Observable 序列（每隔 1 秒钟发出一个索引数）
        let observable1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable1.map({ "当前索引数：\($0 )"})
            .bind { (text) in
                //收到发出的索引数后显示到label上
                self.showLabel2.text = "2. 在 bind 方法中创建观察者 (创建一个定时生成索引的 Observable 序列 , 并将索引数不断显示在 Lable 标签上)\n\n\(text)"
        }
        .disposed(by: disposeBag)
        
        // 3. 使用 AnyObserver 创建观察者 (可以用来描述任意一种观察者)
        // 1. 配合 subscrible 方法使用
        // 2. 配合 bindTo 方法使用 (配合 Observable 的数据绑定方法（bindTo）使用)
        let observer: AnyObserver = AnyObserver<Any>{(event) in
            switch event {
            case .next(let text):
                self.showLabel3.text = text as? String
            case .error(_): break
                
            case .completed: break
                
            }
        }
        
        let observable2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable2.map({"3. 使用 AnyObserver 创建观察者 (可以用来描述任意一种观察者)\n1. 配合 subscrible 方法使用\n2.配合 bindTo 方法使用 (配合 Observable 的数据绑定方法（bindTo）使用)\n\n当前索引数：\($0 )"})
        .bind(to: observer)
        .disposed(by: disposeBag)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
