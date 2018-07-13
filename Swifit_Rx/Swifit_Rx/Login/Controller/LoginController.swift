//
//  LoginController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/5.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class LoginController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var repeatPasswordTextFeild: UITextField!
    
    @IBOutlet weak var repeatPasswordLabel: UILabel!
    
    @IBOutlet weak var registerButton: UIButton!
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "注册"

        let viewModel = RegisterViewModel()
        
        usernameTextField.rx.text.orEmpty
            .bind(to: viewModel.username)
            .disposed(by: disposeBag)
        
        viewModel.usernameUseable
            .bind(to: usernameLabel.rx.validationResult)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
        .bind(to: viewModel.password)
        .disposed(by: disposeBag)
        
        viewModel.passwordUseable
        .bind(to: passwordLabel.rx.validationResult)
        .disposed(by: disposeBag)
        
        repeatPasswordTextFeild.rx.text.orEmpty
        .bind(to: viewModel.rePassword)
        .disposed(by: disposeBag)
        
        viewModel.rePasswordUseable
        .bind(to: repeatPasswordLabel.rx.validationResult)
        .disposed(by: disposeBag)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
