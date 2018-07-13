//
//  TableViewController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/13.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class TableViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MusicCell")
        view.addSubview(tableView)
        return tableView
    }()
    
    let disposeBag = DisposeBag()
    let musicListViewModel = MusicListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //将数据绑定到 tableview 上
        musicListViewModel.data
            .bind(to: tableView.rx.items(cellIdentifier: "MusicCell")){_, music, cell in
                self.initCellUI(music: music, cell: cell)
        }
        .disposed(by: disposeBag)
        
        //tableview 点击响应
        tableView.rx.modelSelected(Music.self).subscribe { (music) in
            print("你选中的歌曲信息【\(music)】")
        }
        .disposed(by: disposeBag)
        
        
        // Do any additional setup after loading the view.
    }
    
    func initCellUI(music: Music,cell: UITableViewCell) {
        let name = UILabel()
        name.text = music.name
        name.textColor = UIColor.darkGray
        name.font = UIFont.systemFont(ofSize: 14.0)
        cell.addSubview(name)
        
        let singer = UILabel()
        singer.text = music.singer
        singer.textColor = UIColor.lightGray
        singer.font = UIFont.systemFont(ofSize: 12.0)
        cell.addSubview(singer)
        
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(singer.snp.left).offset(-10)
//            make.width.equalTo((kScreenWidth - 20) / 2)
        }
        
        singer.snp.makeConstraints { (make) in
            make.top.equalTo(10)
//            make.width.equalTo((kScreenWidth - 20) / 2)
            make.left.equalTo(name.snp.right).offset(10)
            make.bottom.equalTo(-10)
            make.right.equalTo(-10)
        }
        
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
