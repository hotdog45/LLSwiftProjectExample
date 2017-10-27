//
//  LoginRequest.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/4.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit
import ObjectMapper

//账号登录

final class LoginParameter: BaseParameter {
    var name: String?
    var pwd: String?

    override func mapping(map: Map) {
        super.mapping(map: map)
        name >>> map["name"]
        pwd >>> map["pwd"]
    }
}

final class LoginRequest: BaseRequest<LoginParameter> {
    
    init(parameter: LoginParameter?) {
        super.init(url: LoginAPI.Login, parameter: parameter)
    }
    
    public func starRequest(completionHandler: @escaping () -> Void, failedHandler: @escaping FailureHandler) {
        clearAllUserDefaultsData()
        println(self.parameter?.toJSONString() ?? "")
        Networking.loadDataWithParameter(request: self, completion: { (data) in
            
            let transformModel = Mapper<UserBaseInfoModel>().map(JSONObject: data)
            let json = transformModel?.toJSON()
            UserDefaults.standard.set(json, forKey: "transformModel")
            UserDefaults.standard.synchronize()
            completionHandler()
            
        }, failed: failedHandler);
        
    }
    
}
//第三方登录
final class Auth2LoginParameter: BaseParameter {
    var platform: Int?
    var code: String?
    var accessToken: String?
    var loginId: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        platform >>> map["platform"]
        code >>> map["code"]
        accessToken >>> map["accessToken"]
        loginId >>> map["loginId"]
    }
}


final class Auth2LoginRequest: BaseRequest<Auth2LoginParameter> {
    
    init(parameter: Auth2LoginParameter?) {
        super.init(url: LoginAPI.Auth2Login, parameter: parameter)
    }
    
    public func starRequest(completionHandler: @escaping () -> Void, failedHandler: @escaping FailureHandler) {
        clearAllUserDefaultsData()
        
        println(self.parameter?.toJSONString() ?? "")
        Networking.loadDataWithParameter(request: self, completion: { (data) in
            if let transformModel = Mapper<UserBaseInfoModel>().map(JSONObject: data) {
                let json = transformModel.toJSON()
                UserDefaults.standard.set(json, forKey: "transformModel")
                UserDefaults.standard.synchronize()
            }
            else {
                assertionFailure("user base info transformed failed")
            }
            completionHandler()
            
        }, failed: failedHandler);
        
    }
    
}

//忘记密码
final class ForgotPwdParameter: BaseParameter {
    var mobile: String?
    var pwd: String?
    var sign: String?
    var code: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        mobile >>> map["mobile"]
        pwd >>> map["pwd"]
        sign >>> map["sign"]
        code >>> map["code"]
    }
}


final class ForgotPwdRequest: BaseRequest<ForgotPwdParameter> {
    
    init(parameter: ForgotPwdParameter?) {
        super.init(url: LoginAPI.FindPwd, parameter: parameter)
    }
    
    public func starRequest(completionHandler: @escaping () -> Void, failedHandler: @escaping FailureHandler) {
        
        println(self.parameter?.toJSONString() ?? "")
        Networking.loadDataWithParameter(request: self, completion: { (data) in
            println(Mapper<UserBaseInfoModel>().map(JSONObject: data) ?? "" )
            if let transformModel = Mapper<UserBaseInfoModel>().map(JSONObject: data) {
                let json = transformModel.toJSON()
                UserDefaults.standard.set(json, forKey: "transformModel")
                UserDefaults.standard.synchronize()
                println(transformModel)
            }
            else {
                assertionFailure("user base info transformed failed")
            }
            completionHandler()
        }, failed: failedHandler);
        
    }
    
}

//发送验证码
final class SendCodeParameter: BaseParameter {
    var mobile : String?
    var checkType : Int?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        mobile >>> map["mobile"]
        checkType >>> map["checkType"]
    }
}


final class SendCodeRequest: BaseRequest<SendCodeParameter> {
    
    init(parameter: SendCodeParameter?) {
        super.init(url: LoginAPI.SendCode, parameter: parameter)
    }
    
    public func starRequest(completionHandler: @escaping (String) -> Void, failedHandler: @escaping FailureHandler) {
        println(self.parameter?.toJSONString() ?? "")
        Networking.loadDataWithParameter(request: self, completion: { (data) in
            completionHandler(data as! String)
        }, failed: failedHandler);
        
    }
    
}
//MARK--注册

final class registerRequest: BaseRequest<ForgotPwdParameter> {
    init(parameter: ForgotPwdParameter?) {
        super.init(url: LoginAPI.Register, parameter: parameter)
    }
    public func starRequest(completionHandler: @escaping () -> Void, failedHandler: @escaping FailureHandler) {
        println(self.parameter?.toJSONString() ?? "")
        Networking.loadDataWithParameter(request: self, completion: { (data) in
            if let transformModel = Mapper<UserBaseInfoModel>().map(JSONObject: data) {
                let json = transformModel.toJSON()
                UserDefaults.standard.set(json, forKey: "transformModel")
                UserDefaults.standard.synchronize()
                println(transformModel)
            }
            else {
                assertionFailure("user base info transformed failed")
            }
            completionHandler()
        }, failed: failedHandler);
    }
}


//MARK: ---  退出登陆 [/logout.htm]

final class logoutRequest: BaseRequest<BaseParameter> {
    init() {
        super.init(url: LoginAPI.Logout, parameter: nil)
    }
    
    public func starRequest(completionHandler: @escaping () -> Void, failedHandler: @escaping FailureHandler) {
        Networking.loadDataWithParameter(request: self, completion: { (data) in
            completionHandler()
        }, failed: failedHandler)
    }
}



//final class VersionInfoParameter: BaseParameter {
//    var type : Int = 0
//    var build : Int = 0
//
//    override func mapping(map: Map) {
//        super.mapping(map: map)
//        type >>> map["type"]
//        build >>> map["build"]
//    }
//}
//class VersionInfoModel: Mappable {
//    var version = ""
//    var build = 0
//    var auditStatus = 0
//
//    required convenience init?(map: Map) {
//        self.init()
//    }
//
//    func mapping(map: Map) {
//        version <- map["version"]
//        build <- map["build"]
//        auditStatus <- map["auditStatus"]
//    }
//}
//final class VersionInfoRequest: BaseRequest<VersionInfoParameter> {
//
//    init(parameter: VersionInfoParameter?) {
//        super.init(url: LoginAPI.VersionInfo, parameter: parameter)
//    }
//
//    public func starRequest(completionHandler: @escaping (Int) -> Void, failedHandler: @escaping FailureHandler) {
//        println(self.parameter?.toJSONString() ?? "")
//
//        Networking.loadDataWithParameter(request: self, completion: { (data) in
//            if let model = Mapper<VersionInfoModel>().map(JSONObject: data) {
//                completionHandler(model.auditStatus)
//            }
//        }, failed: failedHandler);
//
//    }
//
//}



