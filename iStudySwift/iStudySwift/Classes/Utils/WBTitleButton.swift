//
//  WBTitleButton.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/21.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit

class WBTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI()
    {
        setImage(UIImage(named: "navigationbar_arrow_down"), forState: UIControlState.Normal)
        setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
        setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        sizeToFit()
    }
    
    override func setTitle(title: String?, forState state: UIControlState) {
        super.setTitle(title! + "  ", forState: state)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        /*
            titleLabel?.frame.offsetInPlace(dx: -imageView!.frame.width, dy: 0)
        imageView?.frame.offsetInPlace(dx: titleLabel!.frame.width, dy: 0)
 */
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = (titleLabel?.frame.width)!
    }
    
}
