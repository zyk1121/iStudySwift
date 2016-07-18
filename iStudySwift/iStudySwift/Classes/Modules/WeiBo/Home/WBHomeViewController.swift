//
//  WBHomeViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit

class WBHomeViewController: WBBaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func setupVisitorView() {
        let otherView = WBHomeVisitorView()
        view = otherView
        
        // 登录注册
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WBBaseTableViewController.registerBtnCliked(_:)))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WBBaseTableViewController.loginBtnCliked(_:)))
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "登录", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WBBaseTableViewController.loginBtnCliked(_:))),UIBarButtonItem(title: "退出", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WBBaseTableViewController.quitBtnCliked(_:))),]
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
    }

//    override func loginBtnCliked(btn: UIButton)
//    {
//        //
//        super.loginBtnCliked(btn)
//        
//    }
//    
//    override func registerBtnCliked(btn: UIButton)
//    {
//       super.loginBtnCliked(btn)
//        
//    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
