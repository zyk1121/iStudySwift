//
//  WBPublishViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit
import SDWebImage

class WBPublishViewController: UIViewController {

    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.grayColor()
        setupUI()
        setupData()
        self.view.setNeedsUpdateConstraints()
    }
    
    func setupUI()
    {
        imageView.layer.cornerRadius = 30
        self.view.addSubview(imageView)
    }
    
    func setupData()
    {
        imageView.sd_setImageWithURL(NSURL(string: (WBUserAccount.account?.avatar_large)!))
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        imageView.snp_updateConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(60)
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        self.dismissViewControllerAnimated(true) { 
            SSLog("")
        }
    }
}
