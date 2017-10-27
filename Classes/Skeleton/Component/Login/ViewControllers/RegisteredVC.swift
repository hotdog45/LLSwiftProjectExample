//
//  RegisteredVC.swift
//  KDTK
//
//  Created by 李顺风 on 2017/3/10.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class RegisteredVC: UIViewController {

    public enum Page {
        case Bind
        case Register
        case ForgotPwd
        case ChangePwd
    }
    public var page = Page.Bind
    var ForgotPwdModel = ForgotPwdParameter()
    var SendCodeModel = SendCodeParameter()
    var timer:Timer!
    var i = 60
    @IBOutlet weak var phoneNumTF: UITextField!
    @IBOutlet weak var codeNumTF: UITextField!
    @IBOutlet weak var getCodeBtn: UIButton!
    @IBOutlet weak var LoginBtn: UIButton!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var pwdTF: UITextField!
    @IBOutlet weak var pwd2TF: UITextField!
    @IBOutlet weak var titleLbale: UILabel!
    
    
    @IBAction func getCodeClick(_ sender: Any) {
        getCodeBtn.isEnabled = false
        getCodeBtn.backgroundColor = LLLightBule
        if phoneNumTF.text?.characters.count == 11 {
            SendCodeModel.mobile = phoneNumTF.text
        } else {
            LLHUB("请输入正确的手机号码")
            getCodeBtn.isEnabled = true
            getCodeBtn.backgroundColor = LLMainBule
            return
        }
        switch page {
        case .Register,.Bind:
            SendCodeModel.checkType = 0
        default:
            SendCodeModel.checkType = 1
        }
        SendCode()
        startCountingAnimation()
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func userAgreementClick(_ sender: Any) {
        let web = WebViewController()
        web.urlStr = "\(H5URL)/agreement"
        self.present(web, animated: true, completion: nil)
    }
    
    @IBOutlet weak var userAgreementLab: UILabel!
    @IBOutlet weak var userAgreementClick: UIButton!
    
    
    @IBAction func LoginClick(_ sender: Any) {
        if codeNumTF.text?.characters.count == 6 {
            ForgotPwdModel.code = codeNumTF.text
        } else {
            LLHUB("请输入正确的验证码")
            return
        }
        if phoneNumTF.text?.characters.count == 11 {
            ForgotPwdModel.mobile = phoneNumTF.text
        } else {
            LLHUB("请输入正确的手机号码")
            return
        }
        if pwdTF.text == pwd2TF.text{
            ForgotPwdModel.pwd = pwdTF.text
        }else{
            LLHUB("两次密码不一致")
            return
        }
        switch page {
        case .Bind:
            requsetBindPhone()
        case .Register:
            register()
        default:
            if (pwdTF.text?.characters.count)! < 6 || (pwdTF.text?.characters.count)! > 16 {
                LLHUB("密码不能少于6位或大于16位")
                return
            }
            ForgotPwd()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbale.text = title
        bgView.isHidden = true
        
        getCodeBtn.layer.cornerRadius = 3
        LoginBtn.layer.cornerRadius = 4
        switch page {
        case .Bind:
            bgView.isHidden = false
            LoginBtn.setTitle("绑定手机号", for: .normal)
        case .Register:
            LoginBtn.setTitle("注册", for: .normal)

        case .ForgotPwd:
            LoginBtn.setTitle("确定", for: .normal)
        default:
            LoginBtn.setTitle("修改", for: .normal)
        }
        
        // 创建定时器
        timer = Timer(timeInterval: 1.0,
                      target: self,
                      selector: #selector(startCountingAnimation),
                      userInfo: nil,
                      repeats: true)
    }
    //倒计时
    func startCountingAnimation() {
        if i == 1 {
            self.getCodeBtn.isEnabled = true
            getCodeBtn.backgroundColor = LLMainBule
            self.getCodeBtn.setTitle("重新获取", for: .normal)
            i = 60
            timer.fireDate = NSDate.distantFuture
        } else {
            i = i-1
            UIView.animate(withDuration: 1.0, animations: {
                self.getCodeBtn.setTitle("\(self.i)s", for: .normal)
            })
        }
        
    }
    
//    找回密码
    func ForgotPwd()  {
        let ForgotPwdReq = ForgotPwdRequest.init(parameter: ForgotPwdModel)
        ForgotPwdReq.starRequest(completionHandler: {
            self.dismiss(animated: false)
            LLHUB("修改成功")
        }) { (Reason, message) in
            println(message ?? "")
            LLHUB("修改失败 ")
        }
    }
//    发送验证码
    func SendCode()  {
        let SendCodeReq = SendCodeRequest.init(parameter: SendCodeModel)
        SendCodeReq.starRequest(completionHandler: { (sign) in
            // 将定时器添加到运行循环
            RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
            self.timer.fireDate = NSDate.distantPast
            self.ForgotPwdModel.sign = sign
        }) { (Reason, message) in
            LLHUB("发送失败")
            self.getCodeBtn.isEnabled = true
            self.getCodeBtn.backgroundColor = LLMainBule
        }
    }
    
//    注册
    func register()  {
        let registerReq = registerRequest.init(parameter: ForgotPwdModel)
        registerReq.starRequest(completionHandler: { (sign) in
            self.dismiss(animated: false)
            println(getUserInfo().id)
//            UMessage.addAlias("\(getUserInfo().id)", type: "kdtk") { (message, Error ) in
//                println(message)
//            }
            LoginViewController.IMTokenR()
            LLHUB("注册成功")
        }) { (Reason, message) in
            LLHUB("注册失败")
        }
    }
//    绑定
    private func requsetBindPhone() {
//        let parameter = MemberBindPhoneParameter()
//        parameter.code = codeNumTF.text!
//        parameter.mobile = phoneNumTF.text!
//        parameter.sign = self.ForgotPwdModel.sign!
//        let request = MemberBindPhoneRequest(parameter: parameter)
//        request.starRequest(completionHandler: {() in
//            var userModel = UserBaseInfoModel()
//            userModel = getUserInfo()
//            userModel.mobile = self.phoneNumTF.text!
//            let json = userModel.toJSON()
//            UserDefaults.standard.set(json, forKey: "transformModel")
//            UserDefaults.standard.synchronize()
//            LLHUBSuc("绑定成功！")
//            self.dismiss(animated: true)
//        }, failedHandler: {_,_ in
//            LLHUBErr("绑定失败！")
//        })
    }


}
