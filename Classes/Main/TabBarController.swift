//
//  TabBarController.swift
//  KDTK
//
//  Created by 李顺风 on 2017/1/6.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.setupChildController(childVC: Test1ViewController(), normalImage: UIImage(named: "ic_tk_nor")!, selectedImage: UIImage(named: "ic_tk_pre")!, title: "题库")
        self.setupChildController(childVC: Test2ViewController(), normalImage: UIImage(named: "ic_course_nor")!, selectedImage: UIImage(named: "ic_course_pre")!, title: "课堂")
        self.setupChildController(childVC: TopUpVC(), normalImage: UIImage(named: "ic_group_nor")!, selectedImage: UIImage(named: "ic_group_pre")!, title: "社区")
        self.setupChildController(childVC: Test3ViewController(), normalImage: UIImage(named: "ic_me_nor")!, selectedImage: UIImage(named: "ic_me_pre")!, title: "我的")
        
        self.delegate = self

    }

    
    // MARK: - private function
    private func setupChildController(childVC: UIViewController, normalImage: UIImage, selectedImage: UIImage, title: String) {
        let nav = UINavigationController(rootViewController: childVC)
        childVC.title = title
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.waterBlue()], for: .selected)
        childVC.tabBarItem.image = normalImage.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        childVC.tabBarItem.title = title
        self.addChildViewController(nav)
    }
    

}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
//        if viewController == tabBarController.viewControllers?[3] && !isLogin() {
//            LoginViewController.showLogin()
//            return false
//        }
        return true
    }
}

