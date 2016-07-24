//
//  WBQRCodeViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/24.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

let kWidthForScanLine: CGFloat = 150

class WBQRCodeViewController: UIViewController {
    
    var tabBar: UITabBar = UITabBar()
    
    var containerView: UIView = UIView()
    
    var bgImageView: UIImageView = UIImageView()
    
    var scanLineImageView: UIImageView = UIImageView()
    
    var heightForScanLine: CGFloat = 150

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // 设置了之后全局的都会改变
//        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()// 
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WBQRCodeViewController.closeBtnCliked(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "相册", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(WBQRCodeViewController.photoBtnCliked(_:)))
        setupUI()
        
        // 开始扫描二维码
        
        sacanQRCode()
    }
    
    private func sacanQRCode()
    {
        // 1.判断输入能否添加到会话中
        if !session.canAddInput(input) {
            return
        }
        // 2.判断输出能否添加到会话中
        if !session.canAddOutput(output) {
            return
        }
        // 3.添加输入和输出到会话中
        session.addInput(input)
        session.addOutput(output)
        // 4.设置输出能够解析的数据类型
        output.metadataObjectTypes = output.availableMetadataObjectTypes
        // 5.设置监听解析数据
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        // 添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
//        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.bounds
        // 6.开始扫描
        session.startRunning()
        
        
    }
    
    
    
    func setupUI() {
        view.addSubview(tabBar)
        // tabBar
        let tab1 = UITabBarItem(title: "二维码", image: UIImage(named: "qrcode_tabbar_icon_qrcode"), selectedImage: UIImage(named: "qrcode_tabbar_icon_qrcode_highlighted"))
        tab1.tag = 1
        let tab2 = UITabBarItem(title: "二维码", image: UIImage(named: "qrcode_tabbar_icon_barcode"), selectedImage: UIImage(named: "qrcode_tabbar_icon_barcode_highlighted"))
        tab2.tag = 2
        
        tabBar.setItems([tab1,tab2], animated: true)
        tabBar.delegate = self
         // 默认选择
        tabBar.selectedItem = tabBar.items?.first
        // containerView
        containerView.backgroundColor = UIColor.clearColor()
        containerView.clipsToBounds = true
        view.addSubview(containerView)
        bgImageView.image = UIImage(named: "qrcode_border")
        view.addSubview(bgImageView)
        
        // scanLineImageView
        // qrcode_scanline_barcode
        scanLineImageView.image = UIImage(named: "qrcode_scanline_qrcode")
        scanLineImageView.frame = CGRectMake(0, 0, kWidthForScanLine, heightForScanLine)// 默认宽高
        containerView.addSubview(scanLineImageView)
        
        view.setNeedsUpdateConstraints()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animateForScanLine()
    }
    
    private func animateForScanLine()
    {
        //  设置冲击波动画
        scanLineImageView.frame = CGRectMake(0, -heightForScanLine, kWidthForScanLine, heightForScanLine);
        // 在swift中一般不写self，也不推荐使用self
        // 一般闭包和外界才需要使用self，可以提醒是否需要循环引用处理
        UIView.animateWithDuration(1.5) {
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineImageView.frame = CGRectMake(0, self.heightForScanLine, kWidthForScanLine, self.heightForScanLine)
        }
    }
    
    // MARK:- 懒加载
    // 输入对象
    private lazy var input: AVCaptureDeviceInput = {
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        return try! AVCaptureDeviceInput(device:device)
    }()
    // 会话
    private lazy var session: AVCaptureSession = AVCaptureSession()
    // 输出对象
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    // 预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    
    //MARK: - autolayout
    override func updateViewConstraints() {
        super.updateViewConstraints()
        tabBar.snp_updateConstraints { (make) in
            make.height.equalTo(49)
            make.left.right.bottom.equalTo(0)
        }
        
        containerView.snp_updateConstraints { (make) in
            make.width.equalTo(kWidthForScanLine)
            make.height.equalTo(heightForScanLine)
            make.center.equalTo(self.view)
        }
        
        bgImageView.snp_updateConstraints { (make) in
            make.edges.equalTo(containerView)
        }
        
//        SSLog(containerView.frame)
    }
    
    // MARK:private method
    @objc private func closeBtnCliked(btn: UIBarButtonItem)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func photoBtnCliked(btn: UIBarButtonItem)
    {
        
    }
}

extension WBQRCodeViewController : UITabBarDelegate
{
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem)
    {
        if item.tag == 1 {
            heightForScanLine = 150
            // qrcode_scanline_barcode
            scanLineImageView.image = UIImage(named: "qrcode_scanline_qrcode")
            scanLineImageView.frame = CGRectMake(0, 0, kWidthForScanLine, heightForScanLine)// 默认宽高
        } else {
            heightForScanLine = 50
            // qrcode_scanline_barcode
            scanLineImageView.image = UIImage(named: "qrcode_scanline_barcode")
            scanLineImageView.frame = CGRectMake(0, 0, kWidthForScanLine, heightForScanLine)// 默认宽高
        }
        
        view.setNeedsUpdateConstraints()
        // 移除动画
        scanLineImageView.layer.removeAllAnimations()
        // 重新添加动画
        animateForScanLine()
    }
}

extension WBQRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    // 只要扫描到结果就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        SSLog(metadataObjects.last?.stringValue)
    }

}
