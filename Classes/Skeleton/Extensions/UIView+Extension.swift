//
//  UIView+Extension.swift
//  KDTK
//
//  Created by 李顺风 on 2017/2/25.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            self.frame.origin.x = newValue
        }
        
    }
    /// Y值
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            self.frame.origin.y = newValue
        }
    }
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width

        }
        set {
            self.frame.size.width = newValue
        }
    }
    ///高度
    var height: CGFloat {
        
        get {
            return self.frame.size.height
            
        }
        set {
            self.frame.size.height = newValue
        }
    }
    var size: CGSize {
        
        get {
            return self.frame.size
            
        }
        set {
            self.frame.size = newValue
        }
    }
    var point: CGPoint {
        get {
            return self.frame.origin
            
        }
        set {
            self.frame.origin = newValue
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
