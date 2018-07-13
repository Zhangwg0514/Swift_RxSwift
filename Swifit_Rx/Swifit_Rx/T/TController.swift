//
//  TController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/13.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import SnapKit

let kScreenWidth = UIScreen.main.bounds.width
let kScreenHeight = UIScreen.main.bounds.height

class TController: UIViewController {

    let value1 = UILabel()
    let value2 = UILabel()
    let exchange = UIButton()
    let desc = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        value1.backgroundColor = UIColor.lightGray
        value1.textColor = UIColor.white
        value1.textAlignment = .center
        value1.font = UIFont.systemFont(ofSize: 12)
        value1.text = "Hello"
        self.view.addSubview(value1)
        value1.snp.makeConstraints { (make) in
            make.top.equalTo(84)
            make.left.equalTo(15)
            make.width.equalTo((kScreenWidth - 30) * 0.5)
            make.height.equalTo(30)
        }
        
        value2.backgroundColor = UIColor.lightGray
        value2.textColor = UIColor.white
        value2.textAlignment = .center
        value2.font = UIFont.systemFont(ofSize: 12)
        value2.text = "World"
        self.view.addSubview(value2)
        value2.snp.makeConstraints { (make) in
            make.top.equalTo(84)
            make.right.equalTo(-15)
            make.width.equalTo((kScreenWidth - 40) * 0.5)
            make.height.equalTo(30)
        }
        
        exchange.setTitle("交换", for: .normal)
        exchange.backgroundColor = UIColor.lightGray
        exchange.titleLabel?.font = UIFont.systemFont(ofSize: 12.0)
        exchange.addTarget(self, action: #selector(exchangeClick), for: .touchUpInside)
        self.view.addSubview(exchange)
        exchange.snp.makeConstraints { (make) in
            make.top.equalTo(value1.snp.bottom).offset(10)
            make.left.equalTo(15)
            make.width.equalTo(kScreenWidth - 30)
            make.height.equalTo(40)
        }
        
        desc.backgroundColor = UIColor.lightGray
        desc.textColor = UIColor.white
        desc.textAlignment = .center
        desc.font = UIFont.systemFont(ofSize: 12)
        desc.text = "泛型函数 方法名后面跟了 <T> 占位符 占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，无论 T 代表什么类型。只有 swapTwoValues(_:_:) 函数在调用时，才会根据所传入的实际类型决定 T 所代表的类型。"
        desc.numberOfLines = 0
        self.view.addSubview(desc)
        desc.snp.makeConstraints { (make) in
            make.top.equalTo(exchange.snp.bottom).offset(20)
            make.left.equalTo(15)
            make.width.equalTo(kScreenWidth - 30)
        }
        
    }

    @objc func exchangeClick() {
        swapTwoValues(&value1.text, &value2.text)
    }
    
    // 泛型函数 方法名后面跟了 <T> 占位符 占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，无论 T 代表什么类型。只有 swapTwoValues(_:_:) 函数在调用时，才会根据所传入的实际类型决定 T 所代表的类型。
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let tempValue = a
        a = b
        b = tempValue
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
