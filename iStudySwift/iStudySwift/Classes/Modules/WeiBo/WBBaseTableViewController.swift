//
//  WBBaseTableViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/16.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import Foundation
import UIKit

class WBBaseTableViewController: UITableViewController {

    // 定义标记用户登录的登录状态
    var isLogIn = false
    override func loadView() {
//        super.loadView()
        isLogIn ? super.loadView() : setupVisitorView()
    }
    
    // MARK: - 内部控制方法,子类需要overide
    func setupVisitorView()
    {
        super.loadView()
//        let otherView = WBVisitorView()
//        view = otherView
    }
}
