//
//  WBHomeViewControllerManager.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/24.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit
import Foundation

// 全局常量
public let kWBPresentationDidPresentNotification: String = "kWBPresentationDidPresentNotification"
public let kWBPresentationDidDismissNotification: String = "kWBPresentationDidDismissNotification"

// 地理方法统一写到manager中
class WBHomeViewControllerManager: NSObject, UIViewControllerTransitioningDelegate,UIViewControllerAnimatedTransitioning {

    private var isPresent = false
    
    //MARK-UIViewControllerTransitioningDelegate
    // 该方法负责返回一个负责转场的动画
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController?
    {
        return WBPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    // 负责返回一个负责转场如何出现的对象
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        //        SSLog("出现")
        // 发送通知告诉调用者button状态的改变
        NSNotificationCenter.defaultCenter().postNotificationName(kWBPresentationDidPresentNotification, object: nil)
        isPresent = true
        return self
    }
    
    // 负责返回一个负责转场如何消失的对象
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        //        SSLog("消失")
        NSNotificationCenter.defaultCenter().postNotificationName(kWBPresentationDidDismissNotification, object: nil)
        isPresent = false
        return self
    }

    //MARK - UIViewControllerAnimatedTransitioning
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

    
}
