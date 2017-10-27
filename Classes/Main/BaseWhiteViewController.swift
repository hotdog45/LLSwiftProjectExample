//
//  BaseWhiteViewController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/8/28.
//  Copyright © 2017年 lishunfeng.org. All rights reserved.
//

import UIKit

class BaseWhiteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWhiteBuleNav()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setWhiteBuleNav()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
    }

}
