//
//  KDTK_Reusable.swift
//  KDTK
//
//  Created by 李顺风 on 2016/12/24.
//  Copyright © 2016年 ZHIWU.technology. All rights reserved.
//

import UIKit

protocol Reusable: class {
    
    static var kdReuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    
    static var kdReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: Reusable {
    
    static var kdReuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: Reusable {
    
    static var kdReuseIdentifier: String {
        return String(describing: self)
    }
}

