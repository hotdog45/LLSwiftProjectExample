//
//  UINavigationController+KDTK.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/7.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

extension UIViewController {
    
    
    //题库导航栏样式--白深蓝
    func setDeepBuleNav() {
        self.setupDefaultBackButton()
        self.navigationController?.navigationBar.barTintColor = LLDeepBule
        self.navigationController?.navigationBar.tintColor = .white
        self.setTitleWhiteColor()
    }
    //我的导航栏样式--白蓝
    func setLightBuleNav() {
        self.setupDefaultBackButton()
        self.navigationController?.navigationBar.barTintColor = LLMainBule
        self.navigationController?.navigationBar.tintColor = .white
        self.setTitleWhiteColor()
    }
    //课堂导航栏样式--蓝白
    func setWhiteBuleNav() {
        setupBlueBackButton()
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.tintColor = LLMainBule
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
    }
    
    
    
    //设置白色title
    func setTitleWhiteColor() {
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
    }
   
    
    func setupDefaultBackButton() {
        setupLeftButtonWithImage(image: UIImage(named: "箭头_向左_白色")!, action: #selector(clickedBackButton))
    }
    func setupBlackBackButton() {
        setupLeftButtonWithImage(image: UIImage(named: "ic_back_black")!, action: #selector(clickedBackButton))
    }
    func setupBlueBackButton() {
        setupLeftButtonWithImage(image: UIImage(named: "ic_back_blue")!, action: #selector(clickedBackButton))
    }
    
    func setupLeftButtonWithTitle(title: String, action: Selector? = nil) {
        let item = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        self.navigationItem.leftBarButtonItem = item
    }
    
    func setupLeftButtonWithImage(image: UIImage, action: Selector? = nil) {
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: action)    
        
        self.navigationItem.leftBarButtonItem = item
    }
    
    func setupRightButtonWithTitle(title: String, action: Selector? = nil) {
        let item = UIBarButtonItem(title: title, style: .plain, target: self, action: action)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func setupRightButtonWithImage(image: UIImage, action: Selector? = nil) {
        let item = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func clickedBackButton() {
        let _ = self.navigationController?.popViewController(animated: true)
    }


}
