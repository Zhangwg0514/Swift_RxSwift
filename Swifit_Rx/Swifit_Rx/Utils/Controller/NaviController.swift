//
//  NaviController.swift
//  Swifit_Rx
//
//  Created by zhangwg on 2018/7/4.
//  Copyright © 2018年 white. All rights reserved.
//

import UIKit

class NaviController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = UIColor.orange
        UITabBar.appearance().tintColor = UIColor.orange
        // Do any additional setup after loading the view.
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
