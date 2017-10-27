//
//  Prefix.swift
//  KDTK
//
//  Created by 李顺风 on 2017/2/24.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//
import ObjectMapper

//常用宏定义
// API：
#if DEBUG// 判断是否在测试环境下
let APIURL = "http://api.koudaitiku.net"
#else
let APIURL = "http://api.koudaitiku.com"
#endif


#if DEBUG
let H5URL = "http://m.koudaitiku.net"
#else
let H5URL = "http://m.koudaitiku.com"
#endif

// H5：
#if DEBUG
let ActivityURL = "http://activity.koudaitiku.net"
#else
let ActivityURL = "http://activity.koudaitiku.com"
#endif
/// 自定义打印
///
/// - Parameters:
///   - message: 内容
///   - fileName: 文件名字
///   - methodName: f方法名字
///   - lineNumber: 行号
func DLog<N>(message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
        println("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息:\(message)");
    #endif
}
//构件号
let llbuild = 530

//开发时2  上线1
#if DEBUG
let getAuditStatus = 2
#else
let getAuditStatus = 1
#endif

//审核
func isShenHe() -> Bool{
    let auditStatus = UserDefaults.standard.integer(forKey: "auditStatus525")
    if auditStatus == 2 {
        return false
    }
//    return false
    return getAuditStatus == 2 ? false : true
}

//1.获取屏幕宽度与高度
func screenWidth() -> CGFloat{
    return UIScreen.main.bounds.size.width
}
func screenHeight() -> CGFloat{
    return UIScreen.main.bounds.size.height
}

//let screenWidth = UIScreen.main.bounds.size.width
//let screenHeight = UIScreen.main.bounds.size.height

//2.获取通知中心
let LLNOTI = NotificationCenter.default


//3.设置颜色




// 主题色
let LLMainBule = UIColor.LLColorValue(value: "#1D85DF")
// 浅蓝
let LLLightBule = UIColor.babyBlue()
// 深蓝
let LLDeepBule = UIColor.LLColorValue(value: "#0A3152")
// 背景
let LLbg = UIColor.init(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
// 阴影#1469b2
let LLshadowC = UIColor.LLColorValue(value: "#1469b2")
// 15  91  156
let LLSelBtn = UIColor.init(red: 15/255.0, green: 91/255.0, blue: 156/255.0, alpha: 1)

// 251  82  79 红色
let LLRed = UIColor.init(red: 251/255.0, green: 82/255.0, blue: 79/255.0, alpha: 1)

//绿色
let  LLGreen = UIColor.init(red: 100/255.0, green: 194/255.0, blue: 143/255.0, alpha: 1)

//4.UI布局
let contentSpacing = screenWidth() > 375 ? 30 : 10 as CGFloat

//简写：

//过滤字符串

func strFilter(_ st : String) -> String{
    let str = st.replacingOccurrences(of: "<p>", with: "")
    let str1 = str.replacingOccurrences(of: "<br/>", with: "")
    let str2 = str1.replacingOccurrences(of: "</p>", with: "")
    let str3 = str2.replacingOccurrences(of: "&nbsp;", with: "")
    let str4 = str3.replacingOccurrences(of: "<br />", with: "")
    let str5 = str4.replacingOccurrences(of: "<div>", with: "")
    let str6 = str5.replacingOccurrences(of: "</div>", with: "")
    let str7 = str6.replacingOccurrences(of: "&quot;", with: "")
    return str7
}


//5.设备
let Version = Double(UIDevice().systemVersion)
let IOS10 = (Version! >= 10.0) ? true : false
let IOS9 = (Version! >= 9.0) ? true : false
let IOS8 = (Version! >= 8.0) ? true : false
let IOS7 = (Version! >= 7.0) ? true : false

//let isIOS8 = (Version! >= 8.0)&&(Version! < 9.0) ? true : false

//版本号

// 获取 visibleViewController
func VC()-> UIViewController{
    return UIApplication.topViewController()!
    
    
}
// 判断是否ipad
func isiPad() -> Bool {
    if UIDevice.current.model.hasPrefix("iPad") {
        return true
    }
    return false
}






// 获取 navigationController
func getNAV()-> UINavigationController{
    let TVC = UIApplication.topViewController()
    return (TVC?.navigationController)!
}



// hidesBottomBarWhenPushed
func pushVC(_ viewController: UIViewController, animated: Bool){
    viewController.hidesBottomBarWhenPushed = true
    getNAV().pushViewController(viewController, animated: animated)
}
func presentVC(_ viewController: UIViewController, animated: Bool) {
    getNAV().present(viewController, animated: animated, completion: nil)
}
func presentVC(_ viewController: UIViewController) {
    getNAV().present(viewController, animated: true, completion: nil)
}

// 颜色转图片
func createImage(_ color:UIColor) -> UIImage
{
    let rect = CGRect.init(x: 0.0, y: 0.0, width: 1, height: 1);
    UIGraphicsBeginImageContext(rect.size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
}
// 阴影
func shadowView(_ view:UIView,Radius:CGFloat,color:UIColor)  {
    view.layer.shadowColor = color.cgColor
    view.layer.shadowOffset = CGSize.init(width: 2, height: 2)
    view.layer.shadowOpacity = 0.8
    view.layer.shadowRadius = Radius
}
// 成功提示框
func LLHUBSuc(_ str:String)  {
    SVProgressHUD.showSuccess(withStatus: str)
    SVProgressHUD.dismiss(withDelay: 2.0)
}
// 失败提示框
func LLHUBErr(_ str:String)  {
    SVProgressHUD.showError(withStatus: str)
    SVProgressHUD.dismiss(withDelay: 1.0)
}
// 仅文字提示框
func LLHUB(_ str:String)  {
    SVProgressHUD.show(withStatus: str)
    SVProgressHUD.dismiss(withDelay: 2.0)
}
// 仅文字提示框
func LLHUBLONG(_ str:String)  {
    SVProgressHUD.show(withStatus: str)
    SVProgressHUD.dismiss(withDelay: 5.0)
}
// 提示文案：

let LLUserNameEdit = "用户名不可以小于两个字哦"
let LLUserNameSaveSuccess = "保存成功"

func println(_ item: @autoclosure () -> Any) {
    #if DEBUG
        Swift.print(item())
    #endif
}


// 用户信息：
func getUserInfo() -> UserBaseInfoModel{
    let userid = UserDefaults.standard.value(forKey: "transformModel")
    let transformModel = Mapper<UserBaseInfoModel>().map(JSONObject: userid)
    if transformModel == nil {
        return UserBaseInfoModel()
    }
    return transformModel!
}


func isLogin() -> Bool{
    let userid = UserDefaults.standard.value(forKey: "transformModel")
    let transformModel = Mapper<UserBaseInfoModel>().map(JSONObject: userid)
    if transformModel == nil {
        return false
    }
    return true
}

func getUserName() -> String{
    let UserInfo = getUserInfo()
    return UserInfo.nickName
}

func getUserAvatar() -> String{
    let UserInfo = getUserInfo()
    return UserInfo.avatar
}
func getUserid() -> Int{
    let UserInfo = getUserInfo()
    return UserInfo.id
}

func getTextFont() -> UIFont {
    let i = UserDefaults.standard.integer(forKey: "examTextFont") == 0 ? 14 : UserDefaults.standard.integer(forKey: "examTextFont")
    return UIFont.systemFont(ofSize: CGFloat(i))
}



//   APRouteCenter.init().openUrl(fromTarget: "test.yingtu.co?share")

// 通知名称常量
let NotiPanGesture = NSNotification.Name(rawValue:"notiPanGesture")




// 时间转换
let dateFormatter = DateFormatter()
let currentdate = Date()
//时间戳 转分秒
func timeMMSS(_ timeInterval:TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeInterval)
    dateFormatter.dateFormat = "mm:ss"
    return dateFormatter.string(from: date)
}

//时间戳 年月日时分秒
func timeYYYYMMDDHHMM( _ timeInterval:TimeInterval) -> String {
    let newTimeInterval = timeInterval / 1000
    let date = Date(timeIntervalSince1970: newTimeInterval)
    dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
    return dateFormatter.string(from: date)
}
//时间戳 时分  s
func timeHHMM( _ timeInterval:TimeInterval) -> String {
    let newTimeInterval = timeInterval / 1000
    let date = Date(timeIntervalSince1970: newTimeInterval)
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: date)
}
//时间戳 月日  s
func timeMMDD( _ timeInterval:TimeInterval) -> String {
    let newTimeInterval = timeInterval / 1000
    let date = Date(timeIntervalSince1970: newTimeInterval)
    dateFormatter.dateFormat = "MM月dd日"
    return dateFormatter.string(from: date)
}
//时间戳 年月日
func timeYYYYMMDD( _ timeInterval:TimeInterval) -> String {
    let newTimeInterval = timeInterval / 1000
    let date = Date(timeIntervalSince1970: newTimeInterval)
    dateFormatter.dateFormat = "yyyy.MM.dd"
    return dateFormatter.string(from: date)
}

func clearAllUserDefaultsData() {
//    UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    UserDefaults.standard.removeObject(forKey: "transformModel")
    
    
}

func isHasQQ() -> Bool {
    if UIApplication.shared.canOpenURL(URL(string: "mqq://")!) {
        return true
    }
    return false
}

func isHasWeiBo() -> Bool {
    if UIApplication.shared.canOpenURL(URL(string: "weibo://")!) {
        return true
    }
    return false
}

func isHasWeiXin() -> Bool {
    if UIApplication.shared.canOpenURL(URL(string: "weixin://")!) {
        return true
    }
    return false
}

func getLabHeigh(_ labelStr:String,_ font:UIFont,_ width:CGFloat = 9000) -> CGFloat {
    let statusLabelText: NSString = labelStr as NSString
    let size = CGSize.init(width:width,  height: 9000)
    let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
    return strSize.height
}

func getLabWidth(_ labelStr:String,_ font:UIFont,_ height:CGFloat = 9000) -> CGFloat {
    let statusLabelText: NSString = labelStr as NSString
    let size = CGSize.init(width: 9000, height: height)
    let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
    let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
    return strSize.width
}



//7.字符串

let strTest2 = "<img src=\"http://ojlork64e.bkt.clouddn.com/6923bbe711da434d8a024bc65f620386\" alt=\"\" /><img src=\"http://ojlork64e.bkt.clouddn.com/6a97af26fe814568939295d1976c12b3\" alt=\"\" /><img src=\"http://ojlork64e.bkt.clouddn.com/5e81fdc0beac47979fa4902fcc9d9ad6\" alt=\"\" />"
let strTest3 = "<img src=\"http://ojlork64e.bkt.clouddn.com/6923bbe711da434d8a024bc65f620386\" alt=\"\" /><img src=\"http://ojlork64e.bkt.clouddn.com/6a97af26fe814568939295d1976c12b3\" alt=\"\" /><img src=\"http://ojlork64e.bkt.clouddn.com/5e81fdc0beac47979fa4902fcc9d9ad6\" alt=\"\" />"


