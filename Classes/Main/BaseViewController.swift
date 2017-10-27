//
//  BaseViewController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/4/10.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.setDeepBuleNav()
        setLightBuleNav()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLightBuleNav()
        self.navigationController?.navigationBar.barTintColor = LLMainBule
    }



}
