//
//  Config.swift
//  KDTK
//
//  Created by 李顺风 on 2017/2/6.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

final public class Config {
    
    
    public struct NotificationName {
        // 播放器 全屏/退出全屏 通知
        public static let playerOrientationDidChanged = Notification.Name(rawValue: "KDTK.Notification.playerOrientationDidChanged")
        // WIFi 通知
        public static let WIFIDidChanged = Notification.Name(rawValue:
            "KDTK.Notification.WIFIDidChanged")
        // 无WIFi 通知
        public static let NOWIFIDidChanged = Notification.Name(rawValue:
            "KDTK.Notification.NOWIFIDidChanged")
        
        // 删除地址
        public static let DeleteAddress = Notification.Name(rawValue:
            "KDTK.Notification.DeleteAddress")
        // 默认地址
        public static let DefAddress = Notification.Name(rawValue:
            "KDTK.Notification.DefAddress")
        // 地址模型
        public static let AddressModel = Notification.Name(rawValue:
            "KDTK.Notification.AddressModel")
        // 付款
        public static let reqOrder = Notification.Name(rawValue:
            "KDTK.Notification.reqOrder")
        
        // 付款成功
        public static let OrderSuccess = Notification.Name(rawValue:
            "KDTK.Notification.OrderSuccess")
        
        // 付款失败
        public static let OrderFailure = Notification.Name(rawValue:
            "KDTK.Notification.OrderFailure")
        // 付款失败
        public static let courierIndex = Notification.Name(rawValue:
            "KDTK.Notification.courierIndex")
        
        // 选择快递
        public static let courierBg = Notification.Name(rawValue:
            "KDTK.Notification.courierBg")
        
        // 选择科目
        public static let chooseSubTrue = Notification.Name(rawValue:
            "KDTK.Notification.chooseSubTrue")
        // 选择科目
        public static let chooseSub = Notification.Name(rawValue:
            "KDTK.Notification.chooseSub")
        
        
        // 刷新主页
        public static let reloadAllUI = Notification.Name(rawValue:
            "KDTK.Notification.reloadAllUI")
        
        // 刷新主页数据
        public static let reloadAllData = Notification.Name(rawValue:
            "KDTK.Notification.reloadAllData")
        
        // 刷新主页数据
        public static let reloadQQ = Notification.Name(rawValue:
            "KDTK.Notification.reloadQQ")
        
        // 刷新网页数据
        public static let reloadWebData = Notification.Name(rawValue:
            "KDTK.Notification.reloadWebData")
        
        // 刷新主页数据
        public static let buyEx = Notification.Name(rawValue:
            "KDTK.Notification.buyEx")
        // 更新字体
        public static let reloadTextFont = Notification.Name(rawValue:
            "KDTK.Notification.reloadTextFont")
        
        // 更新快递
        public static let reloadFreight = Notification.Name(rawValue:
            "KDTK.Notification.reloadFreight")
        // 更新优惠券
        public static let reloadCoupons = Notification.Name(rawValue:
            "KDTK.Notification.reloadCoupons")
        
        // 更新字体
        public static let isScrollEnabledfalse = Notification.Name(rawValue:
            "KDTK.Notification.isScrollEnabledfalse")
        
        // 更新快递
        public static let reloadCourseDetail = Notification.Name(rawValue:
            "KDTK.Notification.reloadCourseDetail")
        
        // 下载通知
        public static let DownloadingUpdateNotification = Notification.Name(rawValue:
            "DownloadingUpdateNotification")
        public static let DownloadBeginNotification = Notification.Name(rawValue:
            "DownloadBeginNotification")
        public static let DownloadFinishNotification = Notification.Name(rawValue:
            "DownloadFinishNotification")
        public static let DownloadFailedNotification = Notification.Name(rawValue:
            "DownloadFailedNotification")
        public static let UIDeviceBatteryLowPowerNotification = Notification.Name(rawValue:
            "UIDeviceBatteryLowPowerNotification")
        public static let DownloadM3U8AnalyseFailedNotification = Notification.Name(rawValue:
            "DownloadM3U8AnalyseFailedNotification")
        
        // 购买群
        public static let reloadBuyGroup = Notification.Name(rawValue:
            "KDTK.Notification.reloadBuyGroup")
        public static let openArticleDesc = Notification.Name(rawValue:
            "KDTK.Notification.openArticleDesc")
        
        public static let openFileDesc = Notification.Name(rawValue:
            "KDTK.Notification.openFileDesc")
        public static let openTestDesc = Notification.Name(rawValue:
            "KDTK.Notification.openTestDesc")
        
       
    }
    
    
    static let NormalImageOptionInfos: KingfisherOptionsInfo = [
        .keepCurrentImageWhileLoading,
        .backgroundDecode,
        .scaleFactor(UIScreen.main.scale)
    ]
    
    public static let appGroupID: String = "group.ZhiWu-Inc.KDTK"
    
    public static let baiduAccessKey = "1c4c403b4dbd49959ee7921cf125234d"
    
    public static let defaultPageSize = 10
}
