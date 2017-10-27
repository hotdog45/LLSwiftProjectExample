//
//  LCSwiftConfig.swift
//  FeelfelCode
//
//  Created by 李策 on 2017/5/8.
//  Copyright © 2017年 李策. All rights reserved.
//

import Foundation
import UIKit


let kScreenWidth = UIScreen.main.bounds.size.width
let kScreenHeight = UIScreen.main.bounds.size.height
let kAutoSizeScaleX = kScreenWidth/375.0
let kAutoSizeScaleY = kScreenHeight/667.0





let kDesignHeight : CGFloat = 1334.0
let kDesignWidth :CGFloat = 750.0

func autoWidth(width:CGFloat) -> CGFloat {
    
    return ((width)/kDesignWidth*kScreenWidth )
    
}

func autoHeight(height:CGFloat) -> CGFloat {
    
    return ((height)/kDesignHeight*kScreenHeight )
    
    
}

func textLong(font:CGFloat , content:NSString) -> CGFloat {
    
  
    
   return content.size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: font)]).width
    
    
    
}


//大字
let kMaxTextFont = UIFont.systemFont(ofSize: 16)
//常规
let kMidTextFont = UIFont.systemFont(ofSize: 14)
//小字
let kMinTextFont = UIFont.systemFont(ofSize: 12)
//边框粗细
let kBorderLineThickness : CGFloat = 0.8
//cell边线粗细
let kBorderCellLineThickness : CGFloat = 8
//   cell的常规高
let kCellNormal_H : CGFloat = 44
let kNav_H : CGFloat = 64
let kTabbar_H : CGFloat = 49
let kStutasBar_H : CGFloat = 20

///5s适配比例
func widthDividedBy(width:CGFloat) -> CGFloat{
    return kScreenWidth > 325.0 ? width : width/375*320
}
func heightDividedBy(width:CGFloat) -> CGFloat{
    return kScreenHeight > 570.0 ? width : width/667*568
}


//RGB
func RGBA (_ r:CGFloat, g:CGFloat, b:CGFloat, a:CGFloat) -> UIColor {
    return UIColor (red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}
func kThemeColor() -> UIColor {
    return RGBA(77, g: 160, b: 233, a: 1.0)
}
func anyColor() -> UIColor{
    return RGBA(CGFloat(arc4random()%256), g: CGFloat(arc4random()%256), b: CGFloat(arc4random()%256), a: 1.0)
}

func getLocaleDate(_ date : Date) -> Date {
    /**
     *  获取系统时区的时间
     */
    let zone = TimeZone.current
    
    let interval : Int = zone.secondsFromGMT(for: date)
    let localeDate = date.addingTimeInterval(TimeInterval.init(interval))
    return localeDate
}
func transferStringToColor(hexString:String, alpha:CGFloat) -> UIColor {
    
    var color = UIColor.red
    var cStr : String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
    
    if cStr.hasPrefix("#") {
        let index = cStr.index(after: cStr.startIndex)
        cStr = cStr.substring(from: index)
    }
    if cStr.characters.count != 6 {
        return UIColor.black
    }
    
    let rRange = cStr.startIndex ..< cStr.index(cStr.startIndex, offsetBy: 2)
    let rStr = cStr.substring(with: rRange)
    
    let gRange = cStr.index(cStr.startIndex, offsetBy: 2) ..< cStr.index(cStr.startIndex, offsetBy: 4)
    let gStr = cStr.substring(with: gRange)
    
    let bIndex = cStr.index(cStr.endIndex, offsetBy: -2)
    let bStr = cStr.substring(from: bIndex)
    
    var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
    Scanner(string: rStr).scanHexInt32(&r)
    Scanner(string: gStr).scanHexInt32(&g)
    Scanner(string: bStr).scanHexInt32(&b)
    
    color = UIColor.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    
    return color
}


//背景灰色
func kBgDarkColor() -> UIColor {
    return transferStringToColor(hexString:"#efefef", alpha: 1.0)
}
//背景白色
func kBgWhiteColor() -> UIColor {
    return transferStringToColor(hexString:"#FFFFFF", alpha: 1.0)
}
//边框颜色
func kBorderLineColor() -> UIColor {
    return transferStringToColor(hexString:"#e4e4e4", alpha: 1.0)
}
//默认黑 用于默认黑色
func kMaxBlackColor() -> UIColor {
    return transferStringToColor(hexString:"#303030", alpha: 1.0)
}
//中性黑 用于灰色
func kMidBlackColor() -> UIColor {
    return transferStringToColor(hexString:"#707070", alpha: 1.0)
}
//浅黑 用于textField等placehorder文字颜色 还有时间
func kMinBlackColor() -> UIColor {
    return transferStringToColor(hexString:"#ababab", alpha: 1.0)
}
//用于cell灰色
func kCellBackGroundColor() -> UIColor {
    return transferStringToColor(hexString:"#fafafa", alpha: 1.0)
}
//橙色
func kOrangeColor() -> UIColor {
    return transferStringToColor(hexString:"#ff9900", alpha: 1.0)
}
//红色
func kRedColor() -> UIColor {
    return transferStringToColor(hexString:"#fd0305", alpha: 1.0)
}
//橘红色
func kHyacinthColor() -> UIColor {
    return transferStringToColor(hexString:"#f95b03", alpha: 1.0)
}
//蓝青色
func kIndigoColor() -> UIColor {
    return transferStringToColor(hexString:"#12acf2", alpha: 1.0)
}
//绿色
func kGreenColor() -> UIColor {
    return transferStringToColor(hexString:"#56ba22", alpha: 1.0)
}
//蓝色
func kBlueColor() -> UIColor {
    return transferStringToColor(hexString:"#4cbaff", alpha: 1.0)
}
