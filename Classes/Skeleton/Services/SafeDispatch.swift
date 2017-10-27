//
//  SafeDispatch.swift
//  KDTK
//
//  Created by 李顺风 on 2016/12/24.
//  Copyright © 2016年 lishunfeng.org. All rights reserved.
//

import Foundation

final public class SafeDispatch {
    
    private let mainQueueKey = DispatchSpecificKey<Int>()
    private let mainQueueValue = Int(1)
    
    private static let sharedSafeDispatch = SafeDispatch()
    
    private init() {
        DispatchQueue.main.setSpecific(key: mainQueueKey, value: mainQueueValue)
    }
 
    public class func async(onQueue queue: DispatchQueue = DispatchQueue.main, forWork block: @escaping () -> Void) {
        if queue === DispatchQueue.main {
            if DispatchQueue.getSpecific(key: sharedSafeDispatch.mainQueueKey) == sharedSafeDispatch.mainQueueValue {
                block()
            } else {
                DispatchQueue.main.async {
                    block()
                }
            }
        } else {
            queue.async {
                block()
            }
        }
    }
}
