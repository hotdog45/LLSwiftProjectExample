//
//  UIColor+KDTK.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/6.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

extension UIColor {
    class func mainGrey(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 60/255.0, green: 68/255.0, blue: 82/255.0, alpha: alpha)
    }
    
    class func tableSectionFooterColor() -> UIColor {
        return UIColor(red:0.95, green:0.95, blue:0.95, alpha:1.00)
    }
    
    class func textPrimary(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: alpha)
    }
    
    class func textSecondary(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: alpha)
    }
    
    class func waterBlue(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 29/255.0, green: 133/255.0, blue: 223/255.0, alpha: alpha)
    }
    class func babyBlue(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 155/255.0, green: 209/255.0, blue: 255/255.0, alpha: alpha)
    }
    class func suvaGrey(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 138/255.0, green: 138/255.0, blue: 138/255.0, alpha: alpha)
    }
    class func duckEggBlue(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 202/255, green: 251/255, blue: 236/255, alpha: alpha)
    }
    class func coral(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 251/255, green: 82/255, blue: 79/255, alpha: alpha)
    }
    class func charcoalGrey(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 60/255, green: 68/255, blue: 82/255, alpha: alpha)
    }
    class func whiteSmoke(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: alpha)
    }
    class func pinkishGrey(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: alpha)
    }
    class func greyish50(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 179/255.0, green: 179/255.0, blue: 179/255.0, alpha: alpha)
    }
    class func warmGrey(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 151/255.0, green: 151/255.0, blue: 151/255.0, alpha: alpha)
    }
    class func warmGreyFour(alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: 155/255.0, green: 155/255.0, blue: 155/255.0, alpha: alpha)
    }
    
    /// 字符串颜色转换
    class func LLColorValue (value : String,alpha: CGFloat = 1.0)->UIColor{
        var  str :NSString = value.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
        if value.hasPrefix("#"){
            str=(value as NSString).substring(from: 1) as NSString
        }
        let red = (str as NSString ).substring(to: 2)
        let green = ((str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let blue = ((str as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string:red).scanHexInt32(&r)
        Scanner(string: green).scanHexInt32(&g)
        Scanner(string: blue).scanHexInt32(&b)
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha))
    }
}
