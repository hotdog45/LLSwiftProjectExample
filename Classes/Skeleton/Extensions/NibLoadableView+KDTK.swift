//
//  NibLoadableView+KDTK.swift
//  KDTK
//
//  Created by 李顺风 on 2016/12/24.
//  Copyright © 2016年 ZHIWU.technology. All rights reserved.
//

import UIKit

protocol NibLoadable {
    
    static var nibName: String { get }
}

extension UITableViewCell: NibLoadable {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView: NibLoadable {
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView: NibLoadable {
    
    static var nibName: String {
        return String(describing: self)
    }
}


