//
//  UIBarButtonItem+Extension.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/20.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, target: AnyObject?, action: Selector) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
        btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
        btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        btn.sizeToFit()
        self.init(customView: btn)
    }
}
