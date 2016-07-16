//
//  WBMainViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit


class WBMainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.addChildVc(WBHomeViewController(),title: "首页",image: "tabbar_home",  selectedImage: "tabbar_home_highlighted")
        self.addChildVc(WBMessageViewController(),title: "消息",image: "tabbar_message_center",  selectedImage: "tabbar_message_center_highlighted")
        self.addChildVc(WBDiscoverViewController(),title: "发现",image: "tabbar_discover",  selectedImage: "tabbar_discover_highlighted")
        self.addChildVc(WBMeViewController(),title: "我",image: "tabbar_profile",  selectedImage: "tabbar_profile_highlighted")
        
        
        // 去除tab bar顶部黑线,完全透明了
//        self.tabBar.backgroundImage = UIImage()
//        self.tabBar.shadowImage = UIImage()
        
        // tabbar 添加背景颜色
//        let backView = UIView(frame: CGRectMake(0, 0, SCREEN_WIDTH, 49))
//        backView.backgroundColor = UIColor.grayColor()
//        self.tabBar.insertSubview(backView, atIndex: 0)
//        self.tabBar.opaque = true
        self.tabBar.tintColor = UIColor.orangeColor()
        
    }

    /**
     *  添加一个子控制器
     *
     *  @param childVc       子控制器
     *  @param title         标题
     *  @param image         图片
     *  @param selectedImage 选中的图片
     */
    func addChildVc(childVc: UIViewController, title: String, image: String, selectedImage: String) {
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    //    childVc.view.backgroundColor = [UIColor whiteColor];
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = UIImage(named: image)
//    childVc.tabBarItem.selectedImage = UIImage(named: selectedImage)
    // 禁用图片渲染,还可以去图片的属性，XCODE右边工具栏设置
        childVc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    
    // 设置文字的样式
//        self.tabBar.tintColor = UIColor.orangeColor()

    // 添加子控制器
    let navigationVc: UINavigationController = UINavigationController(rootViewController: childVc)
        
    self.addChildViewController(navigationVc)
    }
}
