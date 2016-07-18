//
//  WBHomeVisitorView.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/18.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import Foundation
import UIKit

class WBHomeVisitorView: UIView {

    // MARK: - property
    var bgView: UIView = UIView()
    var rotationImageView: UIImageView?
    var maskImageView: UIImageView?// 中间
    var iconImageView: UIImageView?
    var titleLabel: UILabel?
    var focuseButton: UIButton?
    
    
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
        
        self.backgroundColor = UIColor(colorLiteralRed: 237/255.0, green: 237.0/255.0, blue: 237.0/255.0, alpha: 1.0)
//        bgView.backgroundColor = UIColor.redColor()
        self.addSubview(bgView)
        
        rotationImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        bgView.addSubview(rotationImageView!)
        
        maskImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
        bgView.addSubview(maskImageView!)
        
        iconImageView = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        bgView.addSubview(iconImageView!)
        
        
        titleLabel = UILabel()
        titleLabel?.text = "关注一些人，回这里看看有什么惊喜"
        titleLabel?.font = UIFont.systemFontOfSize(13)
        titleLabel?.textColor = UIColor.lightGrayColor()
        bgView.addSubview(titleLabel!)
            
        focuseButton = UIButton()
        focuseButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
        focuseButton?.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Highlighted)
        focuseButton?.setTitle("去关注", forState: UIControlState.Normal)
        focuseButton?.setTitle("去关注", forState: UIControlState.Highlighted)
        focuseButton?.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        focuseButton?.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
        bgView.addSubview(focuseButton!)
        
        startAnimation()
        
        self.updateConstraints()
    }
    
    //MARK: - autolayout
    override func updateConstraints() {
        super.updateConstraints();
        
        bgView.snp_updateConstraints { (make) in
            make.left.right.equalTo(self)
            make.centerY.equalTo(self)
        }
        
        rotationImageView?.snp_updateConstraints(closure: { (make) in
            make.top.equalTo(bgView)
            make.centerX.equalTo(self)
            make.bottom.equalTo((self.titleLabel?.snp_top)!).offset(0)
        })
        
        maskImageView?.snp_updateConstraints(closure: { (make) in
            make.center.equalTo(rotationImageView!)
        })
        
        iconImageView?.snp_updateConstraints(closure: { (make) in
            make.center.equalTo(rotationImageView!)
        })
        
        titleLabel?.snp_updateConstraints(closure: { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo((self.focuseButton?.snp_top)!).offset(-20);
        })
        
        focuseButton?.snp_updateConstraints(closure: { (make) in
            make.centerX.equalTo(self)
            make.width.equalTo(80)
            make.height.equalTo(36)
            make.bottom.equalTo(self.bgView)
        })
    }
    
    private func startAnimation()
    {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.toValue = 2 * M_PI
        anim.duration = 20.0
        anim.repeatCount = MAXFLOAT
        anim.removedOnCompletion = false
        rotationImageView?.layer.addAnimation(anim, forKey: nil)
    }

    
}
