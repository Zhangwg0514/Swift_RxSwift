//
//  Service.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/5.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ValidationService {

    static let instance = ValidationService()
    
    private init() {
        
    }
    
    let minCount = 6
    //Observable 可观察序列
    func validateUsername(_ username: String) -> Observable<Result>{
        if username.count == 0 {
            return Observable.just(Result.empty)
        }
        
        if username.count < minCount {
            return Observable.just(Result.failed(message: "用户名长度至少为 6 位"))
        }
        
        if checkHasUsername(username) {
            return Observable.just(Result.failed(message: "用户名已经存在"))
        }
        return Observable.just(.ok(message: "用户名可用"))
    }
    
    func checkHasUsername(_ username: String) -> Bool {
        
        
        return false
    }
    
    func validationPassword(_ password: String) -> Result {
        if password.count == 0 {
            return Result.empty
        }
        
        if password.count < minCount {
            return .failed(message: "密码长度至少为6位")
        }

        return Result.ok(message: "密码可用")
    }
    
    func validationRePassword(_ password: String,_ rePassword: String) -> Result {
        if rePassword.count == 0 {
            return .empty
        }
        
        if rePassword.count < minCount {
            return .failed(message: "密码长度至少为6位")
        }
        
        if rePassword == password {
            return .ok(message: "密码可用")
        }
        
        return .failed(message: "两次密码不一样")
    }
    
}
