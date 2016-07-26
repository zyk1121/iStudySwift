//
//  UserAccount.swift
//  XMGWB
//
//  Created by xiaomage on 15/12/5.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

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
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        self.access_token = aDecoder.decodeObjectForKey("access_token") as? String
        self.expires_in = aDecoder.decodeIntegerForKey("expires_in") as Int
        self.uid = aDecoder.decodeObjectForKey("uid") as? String
        self.expires_Date = aDecoder.decodeObjectForKey("expires_Date") as? NSDate
    }
}

