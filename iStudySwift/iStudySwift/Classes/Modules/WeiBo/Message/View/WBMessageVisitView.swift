//
//  WBMessageVisitView.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/18.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import Foundation
import UIKit

class WBMessageVisitView: UIView {
    // MARK: - property
    var bgView: UIView = UIView()
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
        
        self.addSubview(bgView)
        
        iconImageView = UIImageView(image: UIImage(named: "visitordiscover_image_message"))
        bgView.addSubview(iconImageView!)
        
        
        titleLabel = UILabel()
        titleLabel?.text = "登录后，别人评论你的微薄，给你发消息，都会在这里收到通知"
        titleLabel?.numberOfLines = 0
        titleLabel?.font = UIFont.systemFontOfSize(13)
        titleLabel?.textColor = UIColor.lightGrayColor()
        bgView.addSubview(titleLabel!)
      
        
        rigisterButton = UIButton()
        rigisterButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        rigisterButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Highlighted)
        rigisterButton?.setTitle("注册", forState: UIControlState.Normal)
        rigisterButton?.setTitle("注册", forState: UIControlState.Highlighted)
        rigisterButton?.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        rigisterButton?.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        self.addSubview(rigisterButton!)
        
        
        loginButton = UIButton()
        loginButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        loginButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Highlighted)
        loginButton?.setTitle("登录", forState: UIControlState.Normal)
        loginButton?.setTitle("登录", forState: UIControlState.Highlighted)
        loginButton?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        loginButton?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        self.addSubview(loginButton!)
        
        self.updateConstraints()
    }
    
    //MARK: - autolayout
    override func updateConstraints() {
        super.updateConstraints();
        
        bgView.snp_updateConstraints { (make) in
            make.left.right.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        iconImageView?.snp_updateConstraints(closure: { (make) in
            make.top.equalTo(bgView)
            make.centerX.equalTo(self)
            make.bottom.equalTo((self.titleLabel?.snp_top)!).offset(0)
        })
        
        titleLabel?.snp_updateConstraints(closure: { (make) in
            make.centerX.equalTo(self)
            make.left.equalTo((self.rigisterButton?.snp_left)!).offset(10)
            make.right.equalTo((self.loginButton?.snp_right)!).offset(-10)
            make.bottom.equalTo((self.rigisterButton?.snp_top)!).offset(-20);
        })
        
        rigisterButton?.snp_updateConstraints(closure: { (make) in
            make.right.equalTo(self.snp_centerX).offset(-5);
            make.width.equalTo(100)
            make.height.equalTo(36)
            make.bottom.equalTo(self.bgView)
        })
        
        loginButton?.snp_updateConstraints(closure: { (make) in
            make.left.equalTo(self.snp_centerX).offset(5);
            make.width.equalTo(100)
            make.height.equalTo(36)
            make.bottom.equalTo(self.rigisterButton!)
        })

    }

}
