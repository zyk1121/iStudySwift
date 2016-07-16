//
//  UIButton+Extension.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit

extension UIButton {

    convenience init(imageName: String, backgroundImageName: String) {
        self.init()
        setImage(UIImage(named:imageName), forState: UIControlState.Normal)
        setImage(UIImage(named:imageName + "_highlighted"), forState: UIControlState.Highlighted)
        setBackgroundImage(UIImage(named:backgroundImageName), forState: UIControlState.Normal)
        setBackgroundImage(UIImage(named:backgroundImageName + "_highlighted"), forState: UIControlState.Highlighted)
        sizeToFit()
    }
}