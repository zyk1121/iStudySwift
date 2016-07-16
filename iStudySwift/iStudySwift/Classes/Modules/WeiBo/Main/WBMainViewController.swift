//
//  WBMainViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit


class WBMainViewController: UITabBarController {

    //MARK:-lifecircle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        guard let filePath = NSBundle.mainBundle().pathForResource("MainVCSettings", ofType: "json") else {
            // json 不存在
            return
        }
        
        guard let data = NSData(contentsOfFile: filePath) else {
            return;
        }
        
        do {
            let objc = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [[String:AnyObject]]
//            SSLog(objc)
            for dict in objc {
                let title = dict["title"] as? String
                let vcName = dict["vcName"] as? String
                let imageName = dict["imageName"] as? String
                 self.addChildVc(vcName,title: title,image: imageName)
            }
        } catch {
                    self.addChildVc("WBHomeViewController",title: "首页",image: "tabbar_home")
                    self.addChildVc("WBMessageViewController",title: "消息",image: "tabbar_message_center")
            self.addChildVc("WBNullTableViewController",title:"",image: "")
            
            
                    self.addChildVc("WBDiscoverViewController",title: "发现",image: "tabbar_discover")
                    self.addChildVc("WBMeViewController",title: "我",image: "tabbar_profile")
        
        }
        self.tabBar.tintColor = UIColor.orangeColor()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBar.addSubview(composeButton)
        
        let rect = composeButton.frame.size
        let width = tabBar.bounds.width / CGFloat(childViewControllers.count)
        
        composeButton.frame = CGRectMake(2*width, 0, width, rect.height);
    }
    
    // 通过字符串创建类
    /**
     *  添加一个子控制器
     *
     *  @param childVc       子控制器
     *  @param title         标题
     *  @param image         图片
     *  @param selectedImage 选中的图片
     */
    func addChildVc(childVcName: String?, title: String?, image: String?) {
        
        
        guard let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as? String else {
            SSLog("获取命名空间失败")
            return
        }
        
        var cls: AnyClass? = nil
        if let childName = childVcName {
            cls = NSClassFromString(nameSpace+"."+childName)
        }
        
        guard let clsType = cls as? UITableViewController.Type else {
            SSLog("获取类型失败")
            return
        }
        
        // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
        let childVc: UIViewController = clsType.init()
        
        childVc.title = title;
        //    childVc.view.backgroundColor = [UIColor whiteColor];
        
        // 设置子控制器的tabBarItem图片
        if let _image = image {
            childVc.tabBarItem.image = UIImage(named: _image)
            let selectedImage = _image + "_highlighted"
            //    childVc.tabBarItem.selectedImage = UIImage(named: selectedImage)
            // 禁用图片渲染,还可以去图片的属性，XCODE右边工具栏设置
            childVc.tabBarItem.selectedImage = UIImage(named: selectedImage)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        }
        // 添加子控制器
        let navigationVc: UINavigationController = UINavigationController(rootViewController: childVc)
        
        self.addChildViewController(navigationVc)
    }

    //MARK:-懒加载
    lazy var composeButton: UIButton = {
        ()->UIButton in
        let btn:UIButton = UIButton(imageName: "tabbar_compose_icon_add", backgroundImageName: "tabbar_compose_button")
        /*
        let btn:UIButton = UIButton()
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
 */
        btn.addTarget(self, action: #selector(WBMainViewController.composeBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        
        return btn
    }()
    
    //MARK: - click event
    
    @objc private func composeBtnClick(btn:UIButton) {
        let publishVC: WBPublishViewController = WBPublishViewController()
        self.presentViewController(publishVC, animated: true, completion: nil)
    }
//    func composeBtnClick(btn:UIButton) {
//        SSLog("")
//    }
    
    
    /*
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
 */
}
