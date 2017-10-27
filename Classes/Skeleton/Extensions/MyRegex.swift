//
//  MyRegex.swift
//  KDTK
//
//  Created by 李顺风 on 2017/5/10.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import Foundation


struct MyRegex {
    let regex: NSRegularExpression?
    
    init(_ pattern: String) {
        regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
    }
    
    func match(input: String) -> Bool {
        if let matches = regex?.matches(in: input,
                                                options: [],
                                                range: NSMakeRange(0, (input as NSString).length)) {
            return matches.count > 0
        }
        else {
            return false
        }
    }
}
