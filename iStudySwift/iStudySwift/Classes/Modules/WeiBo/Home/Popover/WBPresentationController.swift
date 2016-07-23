//
//  WBPresentationController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/23.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit

class WBPresentationController: UIPresentationController {
    override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
        super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
    }
    
    // 用于布局转场动画的弹出的控件
    override func containerViewWillLayoutSubviews() {
        // containerview （容器视图）
        // presentedView() 通过该方法能拿到弹出的视图
        
        presentedView()?.frame = CGRect(x: 100, y: 45, width: 200, height: 200)
        
        
        // 
        
//        containerView?.addSubview(coverButton)
        containerView?.insertSubview(coverButton, atIndex: 0)
        coverButton.addTarget(self, action: #selector(WBPresentationController.coverButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    //MARK:- 懒加载
    private var coverButton: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clearColor()
        btn.frame = UIScreen.mainScreen().bounds
        return btn
    }()
    
    @objc private func coverButtonClick()
    {
        //   弹出开控制器消失
        presentedViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}
