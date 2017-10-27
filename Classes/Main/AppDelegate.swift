//
//  AppDelegate.swift
//  KDTK
//
//  Created by shun feng on 2017/1/4.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import Reachability
import SwiftyStoreKit
import UserNotifications



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate ,RCIMReceiveMessageDelegate{
    var reach: Reachability?
    var window: UIWindow?
    var count = 0
//    var sdkConfigDelegate : NTESSDKConfigDelegate?
    /// 通用的空闭包类型，无参数，无返回值
    typealias BackgroundSessionCompletionHandler = () -> Void
    var backgroundSessionCompletionHandler : BackgroundSessionCompletionHandler?
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 是否线上环境
        VersionIRequest()
        //IM
        NIMSDKInit()
        //测试 Bugtags
        #if DEBUG
            Bugtags.start(withAppKey: "1cedb0661d185b9fb55d665806da9c0c", invocationEvent: BTGInvocationEventShake)
        #else
            //Bugtags.start(withAppKey: "cef8ae2cf8c4dd540ee4efd6b5cedf0b", invocationEvent: BTGInvocationEventNone)
        #endif
        UINavigationBar.appearance().isTranslucent = false
        //键盘助手
        IQKeyboardManager.sharedManager().enable = true
        
        //注册三方 分享&登录
        shareInit()
        //友盟统计
        MobClickInit()
        
        //内购
        SwiftyStoreKitInit()
        //友盟通知
//        UMessage.start(withAppkey: "58e45c889f06fd6a19000ed9", launchOptions:
//            launchOptions, httpsEnable: true)//正式
        registerNotifications()
        //活动盒子
//        heziSDKinit()
        //网络监测
        reachability()
        //同步群组信息
        if isLogin() {
//            RCDRCIMDataSource.shareInstance().syncGroups()
        }
//        UMessage.setLogEnabled(true)
        return true
    }
    
    
    //融云IM
    func NIMSDKInit() {
        #if DEBUG
            RCIM.shared().initWithAppKey("sfci50a7s1z0i")
        #else
            RCIM.shared().initWithAppKey("y745wfm8yrafv")
        #endif
        RCIM.shared().enableMessageAttachUserInfo = true
        RCIM.shared().disableMessageAlertSound = true
        RCIM.shared().receiveMessageDelegate = self
//        RCIM.shared().registerMessageType(WMVideoMessage.self)
        //注册文章自定义消息
//        RCIM.shared().registerMessageType(RCDTestMessage.self)
//        //注册文件自定义消息
//        RCIM.shared().registerMessageType(KDFileMessage.self)
//        //注册试卷自定义消息
//        RCIM.shared().registerMessageType(KDChallengeMessage.self)
       
        //IM登录
        if isLogin() {
            LoginViewController.IMTokenR()
            RCIM.shared().currentUserInfo = RCUserInfo(userId: "\(getUserid())", name: getUserName(), portrait: getUserAvatar())
            RCIM.shared().enableMessageAttachUserInfo = true

        }
    }
    func onRCIMReceive(_ message: RCMessage!, left: Int32) {
//        LLHUB("收到消息")
    }
    
    //内购
    func SwiftyStoreKitInit()  {
        SwiftyStoreKit.completeTransactions(atomically: true) { purchases in
            for purchase in purchases {
                if purchase.transaction.transactionState == .purchased
                    || purchase.transaction.transactionState == .restored {
                    if purchase.needsFinishTransaction {
                        // Deliver content from server, then:
                        SwiftyStoreKit.finishTransaction(purchase.transaction)
                    }
//                    print("purchased: \(purchase)")
                }
            }
        }
    }
    
    //通知
    func registerNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        //推送59759a78f43e486eda0019a1//测试
        //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
//        UMessage.registerForRemoteNotifications()
        //iOS10必须加下面这段代码。
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.alert, .badge, .sound],
                                        completionHandler: { (granted : Bool, error :Error?) in
                if granted {
                    //点击允许
                    println("点击允许")
                    
                } else {
                    println("点击不允许")
                }
            })
        } else {
            // Fallback on earlier versions
        }
//        UMessage.setLogEnabled(true)
//        UMessage.setAutoAlert(false)
    }
    
    
    //友盟统计
    func MobClickInit() {
        let MobC = UMAnalyticsConfig.sharedInstance()
        MobC?.appKey = "58e45c889f06fd6a19000ed9";
        MobC?.channelId = "App Store";
        let v = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        MobClick.setAppVersion(v) //配置版本号
        MobClick.setEncryptEnabled(true)
        //        MobClick.setLogEnabled(true) //测试
        MobClick.start(withConfigure: MobC)//配置以上参数后,调用此方法初始化SDK！
    }
    
    //分享
    func shareInit() {
        OpenShare.connectQQ(withAppId: "1103298840")
        OpenShare.connectWeibo(withAppKey: "3755592904")
        OpenShare.connectWeixin(withAppId: "wx59412142b3d02fc8")
    }
    
    
    
    
    //iOS10以下使用这个方法接收通知
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        println("收到新消息Active\(userInfo)")
//        UMessage.didReceiveRemoteNotification(userInfo)
        if application.applicationState == .active {
            // 代表从前台接受消息app
        }else{
            // 代表从后台接受消息后进入app
            if  let url : String =  userInfo["url"] as? String {
//                UrlRouteCenter().urlRouteToVC2(url)
            }
        }
    }
    
    
     //iOS10新增：处理后台点击通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        print("收到新消息Active\(userInfo)")
        
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
//            if  let url : String =  userInfo["url"] as? String {
////                UrlRouteCenter().urlRouteToVC2(url)
//            }
            
//            UMessage.didReceiveRemoteNotification(userInfo)
        }else{
            //应用处于前台时的本地推送接受
        }
    }
   //iOS10新增：处理前台收到通知的代理方法
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
//            UMessage.setAutoAlert(false)
//            UMessage.didReceiveRemoteNotification(userInfo)            
        }else{
            //应用处于前台时的本地推送接受
            
        }
        completionHandler([.alert, .sound])
    }
    //版本信息
    func VersionIRequest() {
//        let parameter = VersionInfoParameter()
//        parameter.type = 2
//        parameter.build = llbuild
//        let request = VersionInfoRequest(parameter: parameter)
//        request.starRequest(completionHandler: { (auditStatus) in
//            UserDefaults.standard.set(auditStatus, forKey: "auditStatus525")
//        }, failedHandler: defaultFailureHandler)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        println(deviceToken.base64EncodedString())
    }
    
    ///////////////////////////////////////////////////////////////////////////////
    //检测网络
    func reachability() {
        self.reach = Reachability.forInternetConnection()
        self.reach!.reachableOnWWAN = false
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged),
                                               name: NSNotification.Name.reachabilityChanged,
                                               object: nil)
        
        self.reach!.startNotifier()
    }
    
    func reachabilityChanged(notification: NSNotification) {
          self.reach!.isReachableViaWWAN()
//        if self.reach!.isReachableViaWiFi()  {
//            //            NotificationCenter.default.post(name: Config.NotificationName.WIFIDidChanged, object: self, userInfo: nil)
//            LLHUBLONG("Wifi 链接")
//            (DownloadManager.shareInstance() as AnyObject).startAllDownload()
//        } else {
//            //            NotificationCenter.default.post(name: Config.NotificationName.NOWIFIDidChanged, object: self, userInfo: nil)
//            (DownloadManager.shareInstance() as AnyObject).pauseAllDownload()
//            LLHUBLONG("Wifi 断开链接")
//           }
    }
    
  
    
    

   
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        self.count = count + 1
        self.backgroundSessionCompletionHandler = completionHandler
    }
    
    
    
    
}

