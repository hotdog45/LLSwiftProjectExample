//
//  UserBaseInfoModel.swift
//  KDTK
//
//  Created by 李顺风 on 2017/2/15.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit
import ObjectMapper

class UserBaseInfoModel: Mappable {
    dynamic var id = 0
    dynamic var email = ""
    dynamic var name = ""
    dynamic var nickName = ""
    dynamic var realName = ""
    dynamic var mobile = ""
    dynamic var avatar = ""
    dynamic var gender = 0
    dynamic var isBindqq = false
    dynamic var isBindwb = false
    dynamic var isBindwx = false
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        name <- map["name"]
        mobile <- map["mobile"]
        avatar <- map["avatar"]
        gender <- map["gender"]
        isBindqq <- map["isBindqq"]
        isBindwb <- map["isBindwb"]
        isBindwx <- map["isBindwx"]
        realName <- map["realName"]
        nickName <- map["nickName"]
    }
    
}


//个人账户信息
class BalanceModel: Mappable {
    var balance = 0
    var address = AddressModel()
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        balance <- map["balance"]
        address <- map["address"]
    }
}

//地址
class AddressModel: Mappable {
    var id = 0
    var contactName = ""
    var contactPhone = ""  //联系电话
    var address = ""  //收货地址
    var def = 0 //是否为默认收货地址
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        contactName <- map["contactName"]
        contactPhone <- map["contactPhone"]
        address <- map["address"]
        def <- map["def"]
    }
}









