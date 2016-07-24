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
    
    var myCard = UIButton(type: UIButtonType.Custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
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
        
        view.layer.addSublayer(customLayer)
        customLayer.frame = view.bounds
//        setOutPutInterstRect()
        // 6.开始扫描
        
//        session.startRunning()
        
        
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
        scanLineImageView.hidden = true
        
        myCard.setTitle("我的名片", forState: UIControlState.Normal)
        myCard.setTitle("我的名片", forState: UIControlState.Highlighted)
        myCard.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        myCard.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        myCard.addTarget(self, action: #selector(WBQRCodeViewController.myCardClick), forControlEvents: UIControlEvents.TouchUpInside)
//        myCard.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(WBQRCodeViewController.myCardClick)))
        view.addSubview(myCard)
        
        view.setNeedsUpdateConstraints()
        
        
    }
    
    @objc private func myCardClick()
    {
        let vc = WBQRCodeCreateViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animateForScanLine()
        
        scanLineImageView.hidden = false
        // 设置感兴趣区域，可以
        setOutPutInterstRect()
        session.startRunning()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        session.stopRunning()
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
    
    private func setOutPutInterstRect()
    {
        // 设置二维码感兴趣区域， 如果在session.stopRunning之前设置就不会闪现，但是为了动态改变还是需要在frame改变之后改变矩形区域的
        let viewRect = self.view.frame
        let containerViewRect = self.containerView.frame
        if containerViewRect.width > 0 {
            // 闪现
            clearCustomLayers()
//            session.stopRunning()
            let x = containerViewRect.origin.y / viewRect.height
            let y = containerViewRect.origin.x / viewRect.width
            let width = containerViewRect.height / viewRect.height
            let height = containerViewRect.width / viewRect.width
            
            output.rectOfInterest = CGRectMake(x, y, width, height)
//            session.startRunning()
//             session.startRunning()
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
    /*
    private lazy var output: AVCaptureMetadataOutput = {
        // 设置扫描区域
        let out = AVCaptureMetadataOutput()
        let viewRect = self.view.frame
        let containerViewRect = self.containerView.frame
        let x = containerViewRect.origin.y / viewRect.height
        let y = containerViewRect.origin.x / viewRect.width
        let width = containerViewRect.height / viewRect.height
        let height = containerViewRect.width / viewRect.width
        out.rectOfInterest = CGRectMake(x, y, width, height)
        
        return out
    }()
 */
    
     private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    // 预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.session)
    
    //  自定义图层
    private lazy var customLayer: CALayer = CALayer()
    
    
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
        
        myCard.snp_updateConstraints { (make) in
            make.bottom.equalTo(tabBar.snp_top).offset(-20)
            make.centerX.equalTo(self.view)
        }
//        SSLog(containerView.frame)
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        setOutPutInterstRect()
    }
    // MARK:private method
    @objc private func closeBtnCliked(btn: UIBarButtonItem)
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @objc private func photoBtnCliked(btn: UIBarButtonItem)
    {
        if !UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            return
        }
        let imagePickVC = UIImagePickerController()
        imagePickVC.delegate = self
        presentViewController(imagePickVC, animated: true, completion: nil)
    }
}

extension WBQRCodeViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
//        SSLog(info)
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        guard let ciImage = CIImage(image: image) else {
            return
        }
        
        // CIDetectorAccuracyHigh当选择的图片不是二维码的时候，用时会比较长
        // CIDetectorTypeFace人脸识别
        let detctor = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])
        
        let results = detctor.featuresInImage(ciImage)
        
        for result in results {
            SSLog((result as! CIQRCodeFeature).messageString)
        }
        
        
        picker.dismissViewControllerAnimated(true, completion: nil)
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
        
//        setOutPutInterstRect()
        
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
        clearCustomLayers()
        // 结果
        var stringVal = metadataObjects.last?.stringValue
        SSLog(stringVal)
//        SSLog(metadataObjects.last)
        // 坐标变换，通过预览图层
        guard let objc = previewLayer.transformedMetadataObjectForMetadataObject(metadataObjects.last as? AVMetadataObject) else {
            return
        }
//        let objcMachineCorners = (objc as! AVMetadataMachineReadableCodeObject).corners
        
        // 对扫描的二维码进行描边
        drawLines(objc as! AVMetadataMachineReadableCodeObject)
    }
    
    private func clearCustomLayers()
    {
        guard let layers = customLayer.sublayers else {
            return
        }
        for layer in layers {
            layer.removeFromSuperlayer()
        }
    }
    
    private func drawLines(objc: AVMetadataMachineReadableCodeObject)
    {
        guard let array = objc.corners else {
            return
        }
        
        // 1.创建图片，用于保存绘制的矩形
        let layer = CAShapeLayer()
        layer.lineWidth = 5
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor
        // 2.创建UIBezierPath,绘制矩形
        let path = UIBezierPath()
        // 
        var point: CGPoint = CGPointZero
        var index:Int = 0
        
        CGPointMakeWithDictionaryRepresentation((array[index] as! CFDictionary), &point)
        path.moveToPoint(point)
        index = 1
        while index < array.count {
            CGPointMakeWithDictionaryRepresentation((array[index] as! CFDictionary), &point)
            path.addLineToPoint(point)
            index = index + 1;
        }
        path.closePath()
        
        
        layer.path = path.CGPath
        // 3.将用于保存矩形的图层添加到界面上
         customLayer.addSublayer(layer)
    }

}
