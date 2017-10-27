//
//  ShareModel.swift
//  KDTK
//
//  Created by 李顺风 on 2017/5/25.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import Foundation
import ObjectMapper

class ShareModel: Mappable {
    var title = ""
    var des = ""
    var url = ""
    var type = 0    //课堂1  知识点2  题目3
    var id = 0
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title <- map["title"]
        des <- map["des"]
        url <- map["url"]
        type <- map["type"]
        id <- map["id"]
    }
}
