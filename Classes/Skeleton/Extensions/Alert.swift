//
//  Alert.swift
//  KDTK
//
//  Created by 李顺风 on 2016/12/26.
//  Copyright © 2016年 ZHIWU.technology. All rights reserved.
//

import UIKit

final class Alert {
    
    class  func alert(title: String, message: String?, dismissTitle: String, inViewController viewController: UIViewController?, withDismissAction dismissAction: (() -> Void)?) {
        
        SafeDispatch.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let action: UIAlertAction = UIAlertAction(title: dismissTitle, style: .default) { action in
                if let dismissAction = dismissAction {
                    dismissAction()
                }
            }
            alertController.addAction(action)
            
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    class func confirmOrCancel(title: String, message: String?, confirmTitle: String, cancelTitle: String, inViewController viewController: UIViewController?, withConfirmAction confirmAction: (() -> Void)?, withCancelAction cancelAction: (() -> Void)?) {
        
        SafeDispatch.async {
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let confirm: UIAlertAction = UIAlertAction(title: confirmTitle, style: .default) { action in
                if let confirmAction = confirmAction {
                    confirmAction()
                }
            }
            
            let cancel: UIAlertAction = UIAlertAction(title: cancelTitle, style: .cancel) { action in
                if let cancelAction = cancelAction {
                    cancelAction()
                }
            }
            
            alertController.addAction(cancel)
            alertController.addAction(confirm)

            viewController?.present(alertController, animated: true, completion: nil)
        }
        
    }
}
