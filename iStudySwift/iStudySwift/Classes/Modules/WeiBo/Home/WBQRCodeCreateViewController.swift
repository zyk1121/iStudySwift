//
//  WBQRCodeCreateViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/24.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit
import Foundation

class WBQRCodeCreateViewController: UIViewController {

    var imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.title = "生成二维码"
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        imageView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(imageView)
        
        view.setNeedsUpdateConstraints()
    }
    
    func setupData()
    {
        // 创建二维码
        // 1.创建滤镜
        let filter = CIFilter(name: "CIQRCodeGenerator")
        // 2.还原滤镜默认属性
        filter?.setDefaults()
        // 3.设置需要生成二维码的数据到滤镜中
        // OC中要求设置的是一个二进制数据
        filter?.setValue("https://www.baidu.com/".dataUsingEncoding(NSUTF8StringEncoding), forKeyPath: "InputMessage")
        // 4.从滤镜从取出生成好的二维码图片
        guard let ciImage = filter?.outputImage else
        {
            return
        }
        
        //        customImageVivew.image = UIImage(CIImage: ciImage)
        imageView.image = createNonInterpolatedUIImageFormCIImage(ciImage, size: 500)
        

    }
    
    
    
    //MARK: - autolayout
    override func updateViewConstraints() {
        super.updateViewConstraints()

        imageView.snp_updateConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(200)
        }
    }
    
    /**
     生成高清二维码
     
     - parameter image: 需要生成原始图片
     - parameter size:  生成的二维码的宽高
     */
    private func createNonInterpolatedUIImageFormCIImage(image: CIImage, size: CGFloat) -> UIImage {
        
        let extent: CGRect = CGRectIntegral(image.extent)
        let scale: CGFloat = min(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent))
        
        // 1.创建bitmap;
        let width = CGRectGetWidth(extent) * scale
        let height = CGRectGetHeight(extent) * scale
        let cs: CGColorSpaceRef = CGColorSpaceCreateDeviceGray()!
        let bitmapRef = CGBitmapContextCreate(nil, Int(width), Int(height), 8, 0, cs, 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImageRef = context.createCGImage(image, fromRect: extent)
        
        CGContextSetInterpolationQuality(bitmapRef,  CGInterpolationQuality.None)
        CGContextScaleCTM(bitmapRef, scale, scale);
        CGContextDrawImage(bitmapRef, extent, bitmapImage);
        
        // 2.保存bitmap到图片
        let scaledImage: CGImageRef = CGBitmapContextCreateImage(bitmapRef)!
        
        return UIImage(CGImage: scaledImage)
    }


}
