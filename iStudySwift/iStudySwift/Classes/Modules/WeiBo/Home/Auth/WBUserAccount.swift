//
//  UserAccount.swift
//  XMGWB
//
//  Created by xiaomage on 15/12/5.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit
import Alamofire

class WBUserAccount: NSObject, NSCoding {
    
    var access_token: String?
    var expires_in: Int = 0
    var uid: String?
    // 真正的过期时间
    var expires_Date: NSDate?
    
    // MARK: - 生命周期方法
    init(dict: [String: AnyObject])
    {
        super.init()
        // 如果要想初始化方法中使用KVC必须先调用super.init初始化对象
        // 如果属性是基本数据类型, 那么建议不要使用可选类型, 因为基本数据类型的可选类型在super.init()方法中不会分配存储空间
        let temp:Int = (dict["expires_in"] as? Int)!
        expires_Date = NSDate(timeIntervalSinceNow: Double(temp))
        self.setValuesForKeysWithDictionary(dict)
    }
    
    // 当KVC发现没有对应的key时就会调用
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    override var description: String {
        return "abc"
    }
    
    // MARK: - 外部控制方法
    // 归档模型
    func saveAccount() -> Bool
    {
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        // 2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("useraccount.plist")
        SSLog(filePath)
        // 3.归档对象
        return NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    /// 定义属性保存授权模型
    static var account: WBUserAccount?
    // 解归档模型
    class func loadUserAccount() -> WBUserAccount?
    {
        // 1.判断是否已经加载过了
        if WBUserAccount.account != nil{
            SSLog("已经有加载过")
            // 直接返回
            return WBUserAccount.account
        }
        
        // 2.尝试从文件中加载
        SSLog("还没有加载过")
        // 1.获取缓存目录的路径
        let path = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last!
        // 2.生成缓存路径
        let filePath = (path as NSString).stringByAppendingPathComponent("useraccount.plist")
        // 3.解归档对象
        guard let account = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? WBUserAccount else
        {
            return nil
        }
        
        guard let date = account.expires_Date else {
            return nil
        }
        
        if date.compare(NSDate()) == NSComparisonResult.OrderedAscending {
            SSLog("过期了")
            return nil
        }
        
        WBUserAccount.account = account
        
        return WBUserAccount.account
    }
    
    /// 判断用户是否登录
    class func isLogin() -> Bool {
        return WBUserAccount.loadUserAccount() != nil
    }
    
    // MARK: - NSCoding
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeObject(access_token, forKey: "access_token")
        aCoder.encodeInteger(expires_in, forKey: "expires_in")
        aCoder.encodeObject(uid, forKey: "uid")
        aCoder.encodeObject(expires_Date, forKey: "expires_Date")
        aCoder.encodeObject(avatar_large, forKey: "avatar_large")
        aCoder.encodeObject(screen_name, forKey: "screen_name")
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
        self.expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
        self.expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
        self.avatar_large = aDecoder.decodeObjectForKey("avatar_large") as? String
        self.screen_name = aDecoder.decodeObjectForKey("screen_name") as? String
    }
    
    var avatar_large: String?
    var screen_name: String?
    
    func loadUserInfo(finished:(account: WBUserAccount?, error: NSError?)->())
    {
        // 准备请求路径
        // 参数
        //GET
        /*
         access_token	true	string	采用OAuth授权方式为必填参数，OAuth授权后获得。
         uid	false	int64	需要查询的用户ID。
         screen_name	false	string	需要查询的用户昵称。
         */
        assert(access_token != nil, "access_token不能为空")
        
        Alamofire.request(.GET, "https://api.weibo.com/2/users/show.json", parameters: ["access_token": access_token!,"uid" : uid!])
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    //                        NSJSONSerialization.JSONObjectWithData(response.data, options: NSJSONReadingOptions.MutableContainers)
                    do {
                        /*
                         ["block_word": 0, "avatar_hd": http://tva4.sinaimg.cn/crop.13.24.254.254.1024/c41778b2gw1e9lrqx0ll1j207v0bt0tn.jpg, "friends_count": 11, "domain": , "verified_reason": , "description": ~我~们~都~只~是~星~尘~, "location": 其他, "urank": 2, "favourites_count": 0, "user_ability": 0, "ptype": 0, "follow_me": 0, "remark": , "bi_followers_count": 0, "lang": zh-cn, "name": puny_zhang, "statuses_count": 0, "id": 3289872562, "star": 0, "following": 0, "verified_reason_url": , "province": 100, "verified_source": , "geo_enabled": 1, "profile_image_url": http://tva4.sinaimg.cn/crop.13.24.254.254.50/c41778b2gw1e9lrqx0ll1j207v0bt0tn.jpg, "profile_url": u/3289872562, "allow_all_act_msg": 0, "url": , "screen_name": puny_zhang, "created_at": Tue Aug 20 08:06:25 +0800 2013, "city": 1000, "credit_score": 80, "allow_all_comment": 1, "mbtype": 0, "verified_type": -1, "class": 1, "idstr": 3289872562, "verified": 0, "followers_count": 2, "pagefriends_count": 0, "online_status": 0, "gender": m, "block_app": 0, "mbrank": 0, "avatar_large": http://tva4.sinaimg.cn/crop.13.24.254.254.180/c41778b2gw1e9lrqx0ll1j207v0bt0tn.jpg, "weihao": , "verified_source_url": , "verified_trade": ]
                         
                         */
                        let jsonObject : AnyObject! = try NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions.MutableContainers)
                        SSLog(jsonObject as! [String : AnyObject])
                        let dict = (jsonObject as! [String : AnyObject])
                        self.avatar_large = dict["avatar_large"] as? String
                        self.screen_name = dict["screen_name"] as? String
                        finished(account: self, error: nil)
                        // 保存用户信息
                    } catch {
                        
                    }
                case .Failure(let error):
                    print(error)
                     finished(account: nil, error: error)
                }
        }

        
    }
}

