//
//  WBAuthViewController.swift
//  iStudySwift
//
//  Created by zhangyuanke on 16/7/26.
//  Copyright © 2016年 zhangyuanke. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftHTTP

// 新浪微博auth授权
/*
 588770173
 app sercrt:11fe6d7da4c42514c5f998b8d83d6bef
 */
// https://api.weibo.com/oauth2/authorize?client_id=588770173&redirect_uri=http://www.baidu.com
// 点击授权后
// https://www.baidu.com/?code=4944c3008ea0b4354fc511ab93fb36d3

class WBAuthViewController: UIViewController {

    let webView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        setupUI()
        setupData()
    }
    
    func setupUI() {
        webView.delegate = self
        view.addSubview(webView)
        
        view.setNeedsUpdateConstraints()
    }
    
    func setupData()
    {
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=588770173&redirect_uri=http://www.baidu.com"
        guard let URL = NSURL(string: urlStr) else {
            return
        }
        let request = NSURLRequest(URL: URL)
        webView.loadRequest(request)
    }
    
    
    
    //MARK: - autolayout
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        webView.snp_updateConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

}

extension WBAuthViewController : UIWebViewDelegate
{
    // 如果返回false代表不允许请求，如果返回true代表允许请求
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        // https://api.weibo.com/oauth2/authorize?client_id=588770173&redirect_uri=http://www.baidu.com
        
        // https://api.weibo.com/oauth2/authorize
        
        // 授权回调页面
        // http://www.baidu.com/?code=dde1aca006e972455d22656b88c9673c
        
        guard let urlStr = request.URL?.absoluteString else {
            return false
        }
        if !urlStr.hasPrefix("http://www.baidu.com/") {
            SSLog("不是授权回调页面")
            return true
        }
        let key = "code="
        
        if urlStr.containsString(key) {
            SSLog("授权成功")
            let code = request.URL!.query?.substringFromIndex(key.endIndex)

            /*
             po NSString(data: response.data!, encoding: NSUTF8StringEncoding)
             ▿ Optional<NSString>
             - Some : {"access_token":"2.00gIydaD0HB7qdf555b74e710ETuLX","remind_in":"157679999","expires_in":157679999,"uid":"3289872562"}
             
             let jsonObject : AnyObject! = NSJSONSerialization.JSONObjectWithData(dataFromTwitter, options: NSJSONReadingOptions.MutableContainers, error: nil)
             if let statusesArray = jsonObject as? NSArray{
             if let aStatus = statusesArray[0] as? NSDictionary{
             if let user = aStatus["user"] as? NSDictionary{
             if let userName = user["name"] as? NSDictionary{
             //Finally We Got The Name
             
             }
             }
             }
             }
             */
            
            
            Alamofire.request(.POST, "https://api.weibo.com/oauth2/access_token", parameters: ["client_id": "588770173","client_secret" : "11fe6d7da4c42514c5f998b8d83d6bef", "grant_type" : "authorization_code","code":code!,"redirect_uri":"http://www.baidu.com"])
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
//                        NSJSONSerialization.JSONObjectWithData(response.data, options: NSJSONReadingOptions.MutableContainers)
                        do {
                        let jsonObject : AnyObject! = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                            self.saveAccountInfo(jsonObject as! [String : AnyObject])
                        } catch {

                        }
                    
//                         print(response.request)// original URL request
//                         print(response.response) // URL response
//                         print(response.data)// server data
//                         print(response.result)// result of response serialization
                    case .Failure(let error):
                        print(error)
                    }
            }
 
            
            /*
            Alamofire.request(.POST, "https://api.weibo.com/oauth2/access_token", parameters: ["client_id": "588770173","client_secret" : "11fe6d7da4c42514c5f998b8d83d6bef", "grant_type" : "authorization_code","code":code!,"redirect_uri":"http://www.baidu.com"])
                .responseJSON { (_, _, JSON, _) in
                    println(JSON)
            }
            
            {
                    
                        self.saveAccountInfo(JSON)
            }
 */

            
 
            
            /*
            let params = ["client_id": "588770173","client_secret" : "11fe6d7da4c42514c5f998b8d83d6bef", "grant_type" : "authorization_code","code":code!,"redirect_uri":"http://www.baidu.com"]
            
            do {
                let opt = try HTTP.POST("https://api.weibo.com/oauth2/access_token", parameters: params)
                opt.start { response in
                    //进行具体的响应操作...
                    print("ok")
                }
            } catch let error {
                print("请求失败: \(error)")
            }
 */
            
        
            
            return false
        }
        
        SSLog("授权失败")
        return false
    }
    
    private func saveAccountInfo(data : [String : AnyObject])
    {
        let account:WBUserAccount = WBUserAccount(dict:data)
        
        SSLog(account.saveAccount())
    }
}
