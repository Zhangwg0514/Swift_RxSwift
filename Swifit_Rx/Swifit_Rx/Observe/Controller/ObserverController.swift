//
//  ObserverController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/18.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SCLAlertView

class ObserverController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ObserveCell")
        view.addSubview(tableView)
        return tableView
    }()
    
    lazy var showLabel: UILabel = {
        let showLabel = UILabel()
        showLabel.backgroundColor = UIColor.lightGray
        showLabel.font = UIFont.systemFont(ofSize: 12)
        showLabel.textAlignment = .center
        showLabel.numberOfLines = 0
        view.addSubview(showLabel)
        view.bringSubview(toFront: showLabel)
        showLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(0)
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(64)
        }
        return showLabel
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. 初始化数据源 让其变为可观察序列
        let items = Observable.just(["一、观察者（Observer）介绍","二、直接在 subscribe、bind 方法中创建观察者","三、使用 AnyObserver 创建观察者","四、使用 Binder 创建观察者","五、自定义可绑定属性","六、RxSwift 自带的可绑定属性（UI 观察者）"])
        // 2. 绑定数据源到 tableview 上
        items.bind(to: tableView.rx.items(cellIdentifier: "ObserveCell")) { (row, element, cell) in
            cell.textLabel?.text = "\(element)"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            cell.textLabel?.textColor = UIColor.darkGray
        }
        .disposed(by: disposeBag)
        
        // 3. 设置点击事件
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            switch indexPath.row {
                case 0:
                    SCLAlertView().showInfo("观察者（Observer）介绍", subTitle: "观察者（Observer）的作用就是监听事件，然后对这个事件做出响应。或者说任何响应事件的行为都是观察者\n\n1. 当我们点击按钮，弹出一个提示框。那么这个“弹出一个提示框”就是观察者 Observer<Void>\n\n2. 当我们请求一个远程的 json 数据后，将其打印出来。那么这个“打印 json 数据”就是观察者 Observer<JSON>")
                case 1:
                    self.setupObserverInSubscribe()
                    self.setupObserverInBind()
                    SCLAlertView().showInfo("直接在 subscribe、bind 方法中创建观察者", subTitle: "1，在 subscribe 方法中创建\n\n（1）创建观察者最直接的方法就是在 Observable 的 subscribe 方法后面描述当事件发生时，需要如何做出响应。\n（2）比如下面的样例，观察者就是由后面的 onNext，onError，onCompleted 这些闭包构建出来的。\n\n2，在 bind 方法中创建\n\n（1）下面代码我们创建一个定时生成索引数的 Observable 序列，并将索引数不断显示在 label 标签上")
                case 2:
                    SCLAlertView().showInfo("使用 AnyObserver 创建观察者", subTitle: "1，配合 subscribe 方法使用\n\n2，配合 bindTo 方法使用")
                    self.setupObserverUseAnyObserver()
                case 3:
                    SCLAlertView().showInfo("使用 Binder 创建观察者", subTitle: "1，基本介绍\n\n（1）相较于AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：\n不会处理错误事件\n确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）\n\n（2）一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。")
                    self.setupObserverUseBinder()
                case 4:
                    self.customBindProperty()
                    self.showLabel.text = "自定义可绑定属性"
                    SCLAlertView().showInfo("自定义可绑定属性", subTitle: "方式一：通过对 UI 类进行扩展\n\n（1）这里我们通过对 UILabel 进行扩展，增加了一个fontSize 可绑定属性。\n（2）运行结果如下，随着序列数的不断增长，标签文字也不断的变大。\n\n方式二：通过对 Reactive 类进行扩展\n既然使用了 RxSwift，那么更规范的写法应该是对 Reactive 进行扩展。这里同样是给 UILabel 增加了一个 fontSize 可绑定属性")
                case 5:
                    self.isBindProperty()
                    SCLAlertView().showInfo("RxSwift 自带的可绑定属性", subTitle: "（1）其实 RxSwift 已经为我们提供许多常用的可绑定属性。比如 UILabel 就有 text 和 attributedText 这两个可绑定属性。\n\n（2）那么上文那个定时显示索引数的样例，我们其实不需要自定义 UI 观察者，直接使用 RxSwift 提供的绑定属性即可。")
                default: break
            }
            
        })
            .disposed(by: disposeBag)
        
        
        // Do any additional setup after loading the view.
    }
 // MARK: - 1. 在 subscribe 方法中创建观察者
    // 创建观察者最直接的放大就是在 Observable 的 subscribe 方法后面描述当事件发生时 ， 需要如何做出响应
    // 观察者就是由 onNext onError onCompleted 这些闭包构建出来的
    func setupObserverInSubscribe() {
        let observable = Observable.of("A","B","C")
        observable.subscribe(onNext: { (element) in
            print(element)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            print("completed")
        }) {
            
        }
    }
    // MARK: - 2. 在 bind 方法中创建观察者
    // 创建一个定时生成索引的 Observable 序列 , 并将索引数不断显示在 Lable 标签上
    // Observable 序列（每隔 1 秒钟发出一个索引数）
    func setupObserverInBind() {
        let observable1 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable1.map({ "当前索引数：\($0 )"})
            .bind { (text) in
                self.title = "0"
                //收到发出的索引数后显示到label上
                self.title = "\(text)"
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - 3. 使用 AnyObserver 创建观察者 (可以用来描述任意一种观察者)
    // 1. 配合 subscrible 方法使用
    // 2. 配合 bindTo 方法使用 (配合 Observable 的数据绑定方法（bindTo）使用)
    func setupObserverUseAnyObserver() {
        let observer: AnyObserver = AnyObserver<Any>{(event) in
            switch event {
            case .next(let text):
                self.title = text as? String
            case .error(_): break
                
            case .completed: break
                
            }
        }
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map({ "当前索引数：\($0 )"})
            .bind(to: observer)
            .disposed(by: disposeBag)
    }
    
    // MARK: - 使用 Binder 创建观察者
    //（1）相较于AnyObserver 的大而全，Binder 更专注于特定的场景。Binder 主要有以下两个特征：
    //不会处理错误事件
    //确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
    //（2）一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息。
    func setupObserverUseBinder() {
        
        let observer: Binder<String> = Binder(showLabel) { (view, text)  in
            //收到发出的索引数后显示到label上
            view.text = text
        }
        
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable.map{ "当前索引数：\($0 )"}
            .bind(to: observer)
        .disposed(by: disposeBag)
        
    }
    
    func customBindProperty() {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        observable
            .map({CGFloat($0)})
            .bind(to: showLabel.fontSize)
            .disposed(by: disposeBag)
    }
    
    func isBindProperty() {
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            observable
        .map({"当前索引数：\($0 )"})
        .bind(to: showLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

extension Reactive where Base: UILabel {
    
    public var text: Binder<String?> {
        return Binder(self.base){label,text in
            label.text = text
        }
    }
    
    public var attributedText: Binder<NSAttributedString?> {
        return Binder(self.base){label,text in
            label.attributedText = text
        }
    }
    
}


