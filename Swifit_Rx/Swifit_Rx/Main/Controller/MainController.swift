//
//  MainController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/4.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class MainController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.addSubview(tableView)
        return tableView
    }()
    
    // 实现 订阅处置机制 订阅将在销毁的时候进行处置 ，他会负责清空里面的资源
    let disposeBag = DisposeBag()
    let mainViewModel = MainViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RxSwift"
        
        // 建立绑定(bind)关系(数据源和tableview建立绑定关系)
        mainViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { (row, model, cell) in
                cell.textLabel?.text = "\(model.name)"
                cell.textLabel?.textColor = UIColor.darkGray
                cell.textLabel?.font = UIFont.systemFont(ofSize: 12)
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MainModel.self)
            .subscribe { (model) in
                
                switch model.element?.className {
                case "LoginController":
                    self.navigationController?.pushViewController(LoginController(), animated: true)
                case "RefreshController":
                    self.navigationController?.pushViewController(RefreshController(), animated: true)
                case "TController":
                    self.navigationController?.pushViewController(TController(), animated: true)
                case "TableViewController":
                    self.navigationController?.pushViewController(TableViewController(), animated: true)
                case "ObserverController":
                    self.navigationController?.pushViewController(ObserverController(), animated: true)

                default: break
                    
                }
                
        }
            .disposed(by: disposeBag)
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

