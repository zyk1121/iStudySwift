//
//  WBVisitorView.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import Foundation
import UIKit

class WBVisitorView: UIView {
// MARK: - property
    var rotationImageView: UIImageView?
    var iconImageView: UIImageView?
    var titleLabel: UILabel?
    var rigisterButton: UIButton?
    var loginButton: UIButton?
    
    
//MARK: - life circle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        self.backgroundColor = UIColor.grayColor()
        setupUI()
        
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    func setupUI() {
        
        loginButton = UIButton()
        loginButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        loginButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Highlighted)
        loginButton?.setTitle("去关注", forState: UIControlState.Normal)
        loginButton?.setTitle("去关注", forState: UIControlState.Highlighted)
        loginButton?.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        loginButton?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        self.addSubview(loginButton!)
        
        self.updateConstraints()
    }
    
    //MARK: - autolayout
    override func updateConstraints() {
        super.updateConstraints();
        
        loginButton?.snp_updateConstraints(closure: { (make) in
            make.center.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(36)
        })
    }
}
