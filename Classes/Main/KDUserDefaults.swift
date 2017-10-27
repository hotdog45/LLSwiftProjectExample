//
//  KDUserDefaults.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/12.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

final public class KDUserDefaults {
    
    static let defaults = UserDefaults(suiteName: Config.appGroupID)!
    static let cookieName = "iOSKey"
    
    public static var isLogined: Bool {
        if let _ = KDUserDefaults.cookies {
            return true
        } else {
            return false
        }
    }
    
    public static var cookies: [HTTPCookie]? {
        set {
            if let newCookies = newValue, newCookies.count > 0  {
                
                KDUserDefaults.defaults.set(newCookies, forKey: "cookies")
            }
            else {
                KDUserDefaults.defaults.set(nil, forKey: "cookies")
            }
        }
        get {
            return KDUserDefaults.defaults.array(forKey: "cookies") as? [HTTPCookie]
        }
    }

    public static func setCookies(withURL url: String) {
        
    }
    
    public class func cleanAllUserDefaults() {
        
        do { // manually reset
            KDUserDefaults.cookies = nil
            defaults.synchronize()
        }
        
        do { // reset standardUserDefaults
            let standardUserDefaults = UserDefaults.standard
            standardUserDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
            standardUserDefaults.synchronize()
        }
    }
}

