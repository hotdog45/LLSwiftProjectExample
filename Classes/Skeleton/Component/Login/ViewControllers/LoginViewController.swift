//
//  LoginViewController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/3/8.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var otherLable: UILabel!
    @IBOutlet weak var weixinBtn: UIButton!
    
    @IBOutlet weak var QQbtn: UIButton!
    
    @IBOutlet weak var weiboBtn: UIButton!
    
    var LoginModel = LoginParameter()
    var Auth2LoginModel = Auth2LoginParameter()
    
    @IBOutlet weak var accountTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBAction func dismissClick(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func registeredClick(_ sender: Any) {
        let vc = RegisteredVC()
        vc.page = .Register
        vc.title = "注册账号"
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func forgotPasswordClcik(_ sender: Any) {
        let vc = RegisteredVC()
        vc.page = .ForgotPwd
        vc.title = "忘记密码"
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func loginClick(_ sender: Any) {
        LoginModel.name = accountTF.text
        LoginModel.pwd = passwordTF.text
        if (LoginModel.name?.characters.count)! < 1 || (LoginModel.pwd?.characters.count)! < 1{
            LLHUB("账号或密码不能为空！")
            return
        }
        let LoginReq = LoginRequest.init(parameter: LoginModel)
        LoginReq.starRequest(completionHandler: {
            self.dismiss(animated: false)
            LLHUB("登录成功")
            NotificationCenter.default.post(name: Config.NotificationName.reloadAllData, object: nil)
            NotificationCenter.default.post(name: Config.NotificationName.reloadWebData, object: nil)
            MobClick.profileSignIn(withPUID: "\(getUserInfo().id)", provider: "ZH")
            print("\(getUserInfo().id)")
//            UMessage.addAlias("\(getUserInfo().id)", type: "kdtk") { (message, Error ) in
//                println(message)
//            }
            LoginViewController.IMTokenR()
        }) { (Reason, message) in
            println(message ?? "")
            LLHUB("\(message ?? "msg")")
        }
   
        
    }
    @IBAction func wechatLoginClick(_ sender: Any) {
        OpenShare.weixinAuth("snsapi_userinfo", success: { (message: [AnyHashable : Any]?) in
            let code = message? ["code"] as! String
            print("\(code)")
            self.Auth2LoginModel.platform = 2
            self.Auth2LoginModel.code = code
            self.Auth2Login()
            
        }) { (message: [AnyHashable : Any]?, Error) in
            print( "xxx" )
        }
    }
    
    @IBAction func QQLoginClick(_ sender: Any) {
        OpenShare.qqAuth("get_user_info", success: { (message: [AnyHashable : Any]?) in
            let access_token = message? ["access_token"] as! String
            let openid = message? ["openid"] as! String
            print("accessToken= \(access_token) openId=\(openid)")
            self.Auth2LoginModel.accessToken = access_token
            self.Auth2LoginModel.platform = 1
            self.Auth2LoginModel.loginId = openid
            self.Auth2Login()
        }) { (_: [AnyHashable : Any]?, Error) in
    
        }
        
    }
    @IBAction func weiboLoginClick(_ sender: Any) {
        OpenShare.weiboAuth("all", redirectURI: "http://sns.whalecloud.com/sina2/callback", success: { (message: [AnyHashable : Any]?) in
            let accessToken = message? ["accessToken"] as! String
            let userID = message? ["userID"] as! String
            print("accessToken= \(accessToken) openId=\(userID)")
            self.Auth2LoginModel.accessToken = accessToken
            self.Auth2LoginModel.platform = 3
            self.Auth2LoginModel.loginId = userID
            self.Auth2Login()
        }) { (_: [AnyHashable : Any]?, Error) in
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius = 4
        
        if !isHasQQ() {
            QQbtn.isHidden = true
        }
        if !isHasWeiBo() {
            weiboBtn.isHidden = true
        }
        if !isHasWeiXin() {
            weixinBtn.isHidden = true
        }
        if !isHasWeiXin() && !isHasWeiBo() && !isHasQQ() {
            otherLable.isHidden = true
        }
        
    }
    
    class public func showLogin(){
        let alert = LoginViewController()
        alert.present()
    }
    func present() {
//        if isIOS8 {
//            LLHUBErr("系统版本过低,请升级至最新版本")
////            if ( [activityVC respondsToSelector:@selector(popoverPresentationController)] ) {
////                activityVC.popoverPresentationController.sourceView = self.view;
////            }
//        }else{
            self.modalTransitionStyle = .crossDissolve
            self.modalPresentationStyle = .fullScreen
            presentVC(self, animated: true)
//        }
        
        
    }
    
    func Auth2Login() {
        let Auth2LoginReq = Auth2LoginRequest.init(parameter: Auth2LoginModel)
        Auth2LoginReq.starRequest(completionHandler: {
            self.dismiss(animated: false)
            LLHUB("登录成功")
            NotificationCenter.default.post(name: Config.NotificationName.reloadAllData, object: nil)
            NotificationCenter.default.post(name: Config.NotificationName.reloadWebData, object: nil)
            MobClick.profileSignIn(withPUID: "\(getUserInfo().id)", provider: "\(String(describing: self.Auth2LoginModel.platform))")
            println(getUserInfo().id)
//            UMessage.addAlias("\(getUserInfo().id)", type: "kdtk") { (message, Error ) in
//             println(message)
//            }
            LoginViewController.IMTokenR()
        }) { (Reason, message) in
            println(message ?? "")
            LLHUB("登录失败 ")
        }
    }
    
    class public func IMTokenR() {
        //同步群组信息
//        RCDRCIMDataSource.shareInstance().syncGroups()
//        let IMTokenR = IMTokenRequest()
//        IMTokenR.starRequest(completionHandler: {  (token) in
//            RCIM.shared().connect(withToken:token,success: { (id) in
//                print("登录成功\(String(describing: id))")
//                RCIM.shared().currentUserInfo = RCUserInfo(userId: "\(getUserid())", name: getUserName(), portrait: getUserAvatar())
//                RCIM.shared().enableMessageAttachUserInfo = true
//            }, error: { (err) in
//                println("token错误")
//            }) {
//                println("token错误")
//            }
//            }, failedHandler: { (reason, errorMessage) in
//                if let errorMessage = errorMessage {
//                    println("errorMessage: >>>\(errorMessage)<<<\n")
//                }
//        })
        
    }


}
