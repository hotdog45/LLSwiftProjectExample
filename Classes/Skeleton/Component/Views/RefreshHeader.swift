//
//  RefreshHeader.swift
//  KDTK
//
//  Created by 李顺风 on 2016/12/26.
//  Copyright © 2016年 ZHIWU.technology. All rights reserved.
//

import UIKit
import MJRefresh

class RefreshHeader: MJRefreshStateHeader {
    
    override func prepare() {
        super.prepare()
        
//        lastUpdatedTimeLabel.isHidden = true
//        
        isAutomaticallyChangeAlpha = true
        
    }

}
