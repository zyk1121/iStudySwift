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
        
        let vc: WBPopoverViewController = WBPopoverViewController()
        // 自定义转场动画
        // 设置转场代理
        vc.transitioningDelegate = self
        // 设置转场动画样式
        vc.modalPresentationStyle = UIModalPresentationStyle.Custom
        
        
        self.presentViewController(vc, animated: true, completion: nil)
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
    
    private var isPresent = false

}

//  代理使用分类实现
extension WBHomeViewController : UIViewControllerTransitioningDelegate
{
    // 该方法负责返回一个负责转场的动画
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
     {
        return WBPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    // 负责返回一个负责转场如何出现的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
//        SSLog("出现")
        isPresent = true
        return self
    }

    // 负责返回一个负责转场如何消失的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
//        SSLog("消失")
        isPresent = false
        return self
    }
}

extension WBHomeViewController :UIViewControllerAnimatedTransitioning
{
    // 告诉系统展现和消失的动画时长
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval
    {
        // 暂时不用 
        return 999
    }
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        // 专门用于管理modal如何展现和消失的，无论是展示还是消失都会调用该方法
        // 注意点：只要我们实现了这个代理方法，那么系统就不会再有默认的动画了
        // 也就是说默认的modal从下至上的动画系统也不会帮我们添加了，所有的动画操作都是我们自己实现，包括视图的添加
        // transitionContext可以获取我们想要的对象
        
        /*
        let  toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        SSLog(toVC)
        SSLog(fromVC)
 */
        
//        guard let  toView = transitionContext.viewForKey(UITransitionContextToViewKey)
//            else {
//                return
//        }
////        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
//        
//        transitionContext.containerView()?.addSubview(toView)
//        
//        
//        // 执行动画
//        toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
//        toView.layer.anchorPoint = CGPointMake(0.5, 0)
////        UIView.animateWithDuration(2.0) { 
////            toView.transform = CGAffineTransformIdentity
////        }
//        UIView.animateWithDuration(0.6, animations: {
//           toView.transform = CGAffineTransformIdentity
//
//            }) { (_) in
//                transitionContext.completeTransition(true)
//        }
        
        if isPresent {
            // 展示
            guard let  toView = transitionContext.viewForKey(UITransitionContextToViewKey)
                else {
                    return
            }
            //        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
            transitionContext.containerView()?.addSubview(toView)
            
            
            // 执行动画
            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
            toView.layer.anchorPoint = CGPointMake(0.5, 0)
            //        UIView.animateWithDuration(2.0) {
            //            toView.transform = CGAffineTransformIdentity
            //        }
            UIView.animateWithDuration(0.6, animations: {
                toView.transform = CGAffineTransformIdentity
                
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        } else
        {
            // 消失
            guard let  fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
                else {
                    return
            }
            //        let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            
//            transitionContext.containerView()?.addSubview(fromView)
            
            
            // 执行动画
//            toView.transform = CGAffineTransformMakeScale(1.0, 0.0)
//            toView.layer.anchorPoint = CGPointMake(0.5, 0)
            //        UIView.animateWithDuration(2.0) {
            //            toView.transform = CGAffineTransformIdentity
            //        }
            UIView.animateWithDuration(0.4, animations: {
                // 动画无法执行，0改为一个很小的值即可0.00001
                fromView.transform = CGAffineTransformMakeScale(1.0, 0.00001)
                
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    // This is a convenience a
}
