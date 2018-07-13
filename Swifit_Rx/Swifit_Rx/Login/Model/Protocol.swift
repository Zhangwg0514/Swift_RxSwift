//
//  Protocol.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/5.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

enum Result {
    case ok(message: String)
    case empty
    case failed(message: String)
}

extension Result {
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
}

extension Result {
    var textColor: UIColor {
        switch self {
        case .ok:
            return UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
        case .empty:
            return UIColor.black
        case .failed:
            return UIColor.red
        }
    }
}

extension Result {
    var description: String {
        switch self {
        case let .ok(message: message):
            return message
        case .empty:
            return ""
        case let .failed(message):
            return message
        }
    }
}


// UIBindingObserver 创建自己的监听者
// UIBindingObserver 是一个类 , 他的初始化方法中，有两个参数，第一个参数是一个元素本身，第一个参数是一个闭包，闭包参数是元素本身，还有他的一个属性。

extension Reactive where Base: UILabel {
    var validationResult: UIBindingObserver<Base, Result> {
        return UIBindingObserver(UIElement: base) { label, result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}

extension Reactive where Base: UITextField {
    var inputEnabled: UIBindingObserver<Base, Result> {
        return UIBindingObserver(UIElement: base) { textFiled, result in
            textFiled.isEnabled = result.isValid
        }
    }
}






