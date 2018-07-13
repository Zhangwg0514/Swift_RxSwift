//
//  RefreshController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/6.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RefreshController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        view.addSubview(tableView)
        return tableView
    }()
    
    var items: [String]!
    
    let header = MJRefreshNormalHeader()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置头部刷新控件
        self.tableView.mj_header = MJRefreshNormalHeader()
        //设置尾部刷新控件
        self.tableView.mj_footer = MJRefreshBackNormalFooter()
        //初始化ViewModel
        let viewModel = RefreshViewModel(
            input: (
                headerRefresh: self.tableView.mj_header.rx.refreshing.asDriver(),
                footerRefresh: self.tableView.mj_footer.rx.refreshing.asDriver()),
            dependency: (
                disposeBag: self.disposeBag,
                networkService: NetworkService()))

        
        //单元格数据的绑定
        viewModel.tableData.asDriver()
            .drive(tableView.rx.items) { (tableView, row, element) -> UITableViewCell in
                let cell = tableView.dequeueReusableCell(withIdentifier: "SwiftCell")!
                cell.textLabel?.text = "\(row+1)、\(element)"
                return cell
        }
        .disposed(by: disposeBag)
        
        //下拉刷新状态结束的绑定
        viewModel.endHeaderRefreshing
            .drive(self.tableView.mj_header.rx.endRefreshing)
            .disposed(by: disposeBag)
        
        //上拉刷新状态结束的绑定
        viewModel.endFooterRefreshing
        .drive(self.tableView.mj_footer.rx.endRefreshing)
        .disposed(by: disposeBag)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
