//
//  MBProgressHUD+Add.swift
//  KDTK
//
//  Created by 李顺风 on 2017/2/22.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit
import MBProgressHUD


class MBProgressHUD_Add: MBProgressHUD {

    
    func showError() {
        showError(error: "网络错误！")
    }
    func showError(error:String) {
        show(text: error, icon: "")
    }
    
    /// 显示一个成功的提示框
    ///
    /// - Parameter success: 字符串
    func showSuccess(success:String) {
        show(text: success, icon: "")
    }
    
    /// 显示一个图片和文字的提示框
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - icon: 图片名称字符串
    func show(text:String,icon:String) {
       
        let view = UIApplication.shared.keyWindow?.subviews.last;
        // 快速显示一个提示信息
        let hud = MBProgressHUD.init(view: view!)
//        hud.labelText = text
        // 设置图片
        hud.customView = UIImageView.init(image: UIImage.init(named: icon))
        // 再设置模式
        hud.mode = MBProgressHUDMode.customView;
        
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true;
        
        // 1秒之后再消失
        hud.hide(animated: true, afterDelay: 2.0)
    }
    
    /// 滑动到底部
    func showNoMoreData() {
        showError(error: "已经到底啦")
    }

}

