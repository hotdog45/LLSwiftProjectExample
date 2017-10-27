//
//  BaseRequest.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/3.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseRequest<T: Mappable> {
    
    var url : String
    var parameter: T?
    var method: Method = .post
    
    init(url: String, method: Method = .post, parameter: T?) {
        self.url = url
        self.method = method
        self.parameter = parameter
    }
}

class BaseResponse: Mappable {
    var code: String!
    var msg: String?
    var data: AnyObject?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        code <- map["code"]
        msg <- map["msg"]
        data <- map["data"]
    }
}

class BaseParameter: Mappable {
    
    init() {}
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
    }
}
