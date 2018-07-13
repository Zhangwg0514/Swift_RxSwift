//
//  RegisterViewModel.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/5.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class RegisterViewModel {
    
    let username = BehaviorRelay<String>(value: "")
    let usernameUseable: Observable<Result>
    
    let password = BehaviorRelay<String>(value: "")
    let passwordUseable: Observable<Result>
    
    let rePassword = BehaviorRelay<String>(value: "")
    let rePasswordUseable: Observable<Result>
    

    init() {
        let service = ValidationService.instance
        usernameUseable = username.asObservable()
            .flatMapLatest{ username in
                return service.validateUsername(username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(.failed(message: "username检测出错"))
            }.share(replay: 1)
        
        passwordUseable = password.asObservable().map { passWord in
            return service.validationPassword(passWord)
            }.share(replay: 1)
        
        rePasswordUseable = Observable.combineLatest(password.asObservable(), rePassword.asObservable()) {
            return service.validationRePassword($0, $1)
            }.share(replay: 1)
    }
    
}
