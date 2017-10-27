//
//  UIViewController+Alert.swift
//  KDTK
//
//  Created by 李顺风 on 2016/12/26.
//  Copyright © 2016年 lishunfeng.org. All rights reserved.
//

import UIKit
import Proposer

extension UIViewController {
    
    /*
     * 访问用户资源受限时的提示
     */
    
    
    
    
    func alertCanNotAccessCameraRoll() {
        
        SafeDispatch.async {
            Alert.confirmOrCancel(title: "抱歉", message: "口袋题库不能访问您的相册！\n但您可以在iOS设置里修改设定。", confirmTitle: "现在去设置", cancelTitle: "了解", inViewController: self, withConfirmAction: {
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }, withCancelAction: nil)
        }
    }
    
    func alertCanNotOpenCamera() {
        
        SafeDispatch.async {
            Alert.confirmOrCancel(title: "抱歉", message: "口袋题库不能打开您的相机！\n但您可以在iOS设置里修改设定。", confirmTitle: "现在去设置", cancelTitle: "了解", inViewController: self, withConfirmAction: {
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }, withCancelAction: nil)
        }
    }
    
    func alertCanNotAccessMicrophone() {
        
        SafeDispatch.async {
            Alert.confirmOrCancel(title: "抱歉", message: "口袋题库不能访问您的麦克风！\n但您可以在iOS设置里修改设定。", confirmTitle: "现在去设置", cancelTitle: "了解", inViewController: self, withConfirmAction: {
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }, withCancelAction: nil)
        }
    }
    
    func alertCanNotAccessContacts() {
        
        SafeDispatch.async {
            Alert.confirmOrCancel(title: "抱歉", message: "口袋题库不能读取您的通讯录！\n但您可以在iOS设置里修改设定。", confirmTitle: "现在去设置", cancelTitle: "了解", inViewController: self, withConfirmAction: {
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }, withCancelAction: nil)
        }
    }
    
    func alertCanNotAccessLocation() {
        
        SafeDispatch.async {
            Alert.confirmOrCancel(title: "抱歉", message: "口袋题库不能获取您的位置信息！\n但您可以在iOS设置里修改设定。", confirmTitle: "现在去设置", cancelTitle: "了解", inViewController: self, withConfirmAction: {
                
                UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
                
            }, withCancelAction: nil)
        }
    }
    
    /*
     * 以下是如果必须打开某项功能才能使流程继续下去的提示
     */
    
    func showProposeMessageIfNeedForContactsAndTryPropose(_ propose: @escaping Propose) {
        
        if PrivateResource.camera.isNotDeterminedAuthorization {
            
            SafeDispatch.async {
                
                Alert.confirmOrCancel(title: "注意", message: "口袋题库需要打开您的照相机来继续此次操作。\n您同意吗？", confirmTitle: "OK", cancelTitle: "暂不", inViewController: self, withConfirmAction: {
                    
                    propose()
                    
                }, withCancelAction: nil)
            }
            
        } else {
            propose()
        }
    }
    
    func showTabBar() {
        
    }
    
    func hideTabBar() {
        
        
        
//        if (self.tabBarController.tabBar.hidden == YES) {
//            return;
//        }
//        UIView *contentView;
//        if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
//        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//        else
//        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
//        contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
//        self.tabBarController.tabBar.hidden = YES;
        
//        if self.tabBarController.tabBar.hidden == true {
//            return
//        }
//        let contentView = UIView()
//        if  self.tabBarController.view.subviews.index(after: 0) == UITabBar.classForCoder()
//            [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] {
//        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
//        }else{
//            
//        }

        
        
        
        
    }
    
}
