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
        if isLogIn {
            // 设置导航栏按钮
            /*
            let leftButton = UIButton()
            leftButton.setImage(UIImage(named: "navigationbar_friendattention"), forState: UIControlState.Normal)
            leftButton.setImage(UIImage(named: "navigationbar_friendattention_highlighted"), forState: UIControlState.Highlighted)
            leftButton.sizeToFit()
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
            
            let rightButton = UIButton()
            rightButton.setImage(UIImage(named: "navigationbar_pop"), forState: UIControlState.Normal)
            rightButton.setImage(UIImage(named: "navigationbar_pop_highlighted"), forState: UIControlState.Highlighted)
            rightButton.sizeToFit()
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightButton)
 */
//            navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention")
//            navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop")
            navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "navigationbar_friendattention", target: self, action: #selector(WBHomeViewController.leftButtonClick))
            navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "navigationbar_pop", target: self, action: #selector(WBHomeViewController.rightButtonClick))
            
            
            // 设置titleView
         /*   let titleButton = WBTitleButton()
            titleButton.setTitle("首页", forState: UIControlState.Normal)
            titleButton.setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
            titleButton.setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
            titleButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
            titleButton.addTarget(self, action: #selector(WBHomeViewController.titleButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
            titleButton.sizeToFit()
            self.navigationItem.titleView = titleButton
 */
            let titleButton = WBTitleButton()
            titleButton.setTitle("首页", forState: UIControlState.Normal)
            titleButton.addTarget(self, action: #selector(WBHomeViewController.titleButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
            self.navigationItem.titleView = titleButton
        }
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
    
    @objc private func leftButtonClick()
    {
        // 查找朋友
    }
    
    @objc private func rightButtonClick()
    {
        // 扫码二维码
        
    }
    
    @objc private func titleButtonClick(btn: WBTitleButton)
    {// 标题
        btn.selected = !btn.selected
        
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
