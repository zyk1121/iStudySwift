//
//  MainViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/15.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

/*
 .gitignore
 
 
 .DS_Store
 build
 *.mode1v3
 *.pbxuser
 project.xcworkspace
 xcuserdata
 .svn
 DerivedData
 *.orig
 *.xccheckout
 
 Pods/
 */
import UIKit
import SnapKit
import Alamofire
import SwiftHTTP
import QorumLogs

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var listData:[String]?
    var listViewControllers:[UIViewController]?
    var tableView:UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Swift"
        self.view.backgroundColor = UIColor.whiteColor()
        // 返回
        let returnButtonItem : UIBarButtonItem = UIBarButtonItem()
        returnButtonItem.title = "返回"
        self.navigationItem.backBarButtonItem = returnButtonItem
        
        self.setupData()
        self.setupUI()
        
//        self.testLog()
        self.testLog2()
    }
    
    func testLog2() {
        SSLogEnabled = true
        SSLog("abc")
        SSLog(1)
        SSLog(3.14)
    }
    
    func testLog() {
        QorumLogs.enabled = true
        QorumLogs.minimumLogLevelShown = 2
        QorumLogs.test()
        QL1("1")
        QL2("2")
        QL3("3")
        QL4("4")
        QLPlusLine()
        QLShortLine()
    }
    
    func setupData() {
        
        listData = [String]()
        listViewControllers = [UIViewController]()
        // 1
        listData?.append("WeiBo")
        listViewControllers?.append(WBMainViewController())
        // 2
        listData?.append("HTTP")
        listViewControllers?.append(HTTPMainViewController())
    }
    
    func setupUI() {
        //创建表视图
        self.tableView = UITableView(frame: self.view.frame, style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView?.tableFooterView = UIView(frame: CGRectZero)
        //创建一个重用的单元格
        self.tableView!.registerClass(UITableViewCell.self,
                                      forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview((self.tableView)!)
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
        self.tableView?.snp_updateConstraints(closure: { (make) in
            make.edges.equalTo(self.view)
        })
    }
    
    // tableView
    
    //在本例中，只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listData!.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60;
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell
    {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        /*unable to dequeue a cell with identifier SwiftCell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'*/
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify,
                                                               forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = self.listData![indexPath.row]
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        self.selectRow(indexPath.row)
    }
    
    func selectRow(row : Int) {
        let vc : UIViewController = self.listViewControllers![row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
