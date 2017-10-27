//
//  Networking.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/3.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire
import ObjectMapper

public enum Method: String, CustomStringConvertible {
    case get = "GET"
    case head = "HEAD"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    
    public var description: String {
        return self.rawValue
    }
}

public enum NetworkStatus: String {
    case unknown = "Unknown"
    case notReachable = "NotReachable"
    case WiFi = "EthernetOrWiFi"
    case WWAN = "WWAN"
}
let headers: HTTPHeaders = [
    "Referer" : "http://app.koudaitiku.com"
]

public enum ErrorCode: String {
    case incorrectUserNameOrPassword = "4001"
    case needLogin = "401"
    case needCharges = "403"
    case resourceNotFound = "404"
    case existed = "410"
    case phoneNumberRegistered = "4101"
    public var description: String {
        switch self {
        case .incorrectUserNameOrPassword:
            return "incorrect username Or password"
        case .needLogin:
//            LoginViewController.showLogin()
            LLHUBErr("请登录后再试！")
            return "need login"
        case .needCharges:
            return "need charges"
        case .resourceNotFound:
            return "resource not found"
        case .existed:
            return "existed"
        case .phoneNumberRegistered:
            return "phone Number has been registered"
        }
    }
}

public enum Reason: CustomStringConvertible {
    case couldNotParseJSON
    case noData
    case noSuccessStatusCode(errorCode: ErrorCode?)
    case other(Error?)
    
    public var description: String {
        switch self {
        case .couldNotParseJSON:
            return "Could not parse JSON"
        case .noData:
            return "No Data"
        case .noSuccessStatusCode(let code):
            return "No Success Status Code: \(String(describing: code?.description))"
        case .other(let error):
            return "Other, Error: \(String(describing: error))"
        }
    }
}

public typealias FailureHandler = (_ reason: Reason, _ errorMessage: String?) -> Void

public let defaultFailureHandler: FailureHandler = { (reason, errorMessage) in
    println("\n***** YepNetworking Failure *****")
    println("Reason: \(reason)")
    if let errorMessage = errorMessage {
        println("errorMessage: >>>\(errorMessage)<<<\n")
    }
}

struct Networking {

    public static func loadDataWithParameter<U: Mappable>(request: BaseRequest<U>, completion: @escaping (AnyObject?) -> Void, failed: @escaping FailureHandler) {
        let urlStr = APIURL + request.url
        println("URL: " + urlStr)
        println("Parameter: " + (request.parameter?.toJSONString() ?? ""))
        
        Alamofire.request(urlStr, method: .post, parameters: request.parameter?.toJSON(), encoding: URLEncoding.default,headers: headers).validate(contentType: ["application/json"]).responseJSON { response in
            
            println(response)
//            updateCookies(response: response)
            switch response.result {
            case .success:
                if let resultModel = Mapper<BaseResponse>().map(JSONObject: response.result.value) {
                    
                    println(resultModel)

                    if resultModel.code == "200" {
                        completion(resultModel.data)
                    } else if resultModel.code == "402" {
                        LLHUB("收费项目，请先购买！")
                    } else if resultModel.code == "400" {
                        LLHUB(resultModel.msg!)
                    }else {
                        SVProgressHUD.dismiss()
                        let errorCode = ErrorCode(rawValue: resultModel.code)
                        failed(.noSuccessStatusCode(errorCode: errorCode), errorCode?.description)
                    }
                }
                else {
                    SVProgressHUD.dismiss()
                    failed(.couldNotParseJSON, Reason.couldNotParseJSON.description )
                }
            case .failure(let error):
                SVProgressHUD.dismiss()
                failed(.other(error), Reason.other(error).description)
            }
        }
    }
    
    static func updateCookies(response: DataResponse<Any>) {
        if let headerFields = response.response?.allHeaderFields as? [String: String],
            let URL = response.request?.url {
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: headerFields, for: URL)
            println(cookies)
            
//            let cookies2 = HTTPCookieStorage.shared.cookies(for: URL)
//            println(cookies2 ?? "")
//            if (cookies2?.count)! > 0 {
//                HTTPCookieStorage.shared.setCookie((cookies2?[0])!)
////
//            }
            
            
//            HTTPHeaders.init(dictionaryLiteral: ("Cache-Control","max-age=0"))
//       HTTPCookieStorage.shared.setCookies(KDUserDefaults.cookies!, for: nil, mainDocumentURL: nil)
            
            Alamofire.SessionManager.default.session.configuration.httpCookieStorage?.setCookies(cookies, for: URL, mainDocumentURL: nil)
        }
    }


}



















