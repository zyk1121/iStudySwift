//
//  WBPopoverViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/23.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import Foundation
import UIKit

class WBPopoverViewController: UIViewController {

    var bgImageView: UIImageView = UIImageView(image: UIImage(named: "popover_background"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupData()
        setupUI()
        self.view.setNeedsUpdateConstraints()
    }
    
    private func setupData()
    {
    
    }
    
    private func setupUI()
    {
        self.view.addSubview(bgImageView)
    }
    
    //MARK: - autolayout
    override func updateViewConstraints() {
        super.updateViewConstraints()
        bgImageView.snp_updateConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        
    }
}
