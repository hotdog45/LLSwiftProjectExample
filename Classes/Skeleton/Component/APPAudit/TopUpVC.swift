//
//  TopUpVC.swift
//  KDTK
//
//  Created by 李顺风 on 2017/6/13.
//  Copyright © 2017年 ZHIWU.technology. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import StoreKit

enum RegisteredPurchase: String {
    
    case purchase1
    case purchase2
    case nonConsumablePurchase //非耗材采购
    case consumablePurchase //耗材采购
    case autoRenewablePurchase  //自动续费
    case nonRenewingPurchase //非重新购买
    
}


class TopUpVC: BaseViewController {
    
    let appBundleId = "com.yt.kdtk"
    fileprivate let identifier1 = "com.yunti.kdtk.1.alternate_tier_a"
    fileprivate let identifier6 = "com.yunti.kdtk.6.tier_1"
    fileprivate let identifier18 = "com.yunti.kdtk.18.tier_3"
    fileprivate let identifier30 = "com.yunti.kdtk.30.tier_5"
    fileprivate let identifier50 = "com.yunti.kdtk.50.tier_8"
    fileprivate let identifier93 = "com.yunti.kdtk.93.tier_14"
    fileprivate let identifier168 = "com.yunti.kdtk.168.tier_26"
    fileprivate let identifier248 = "com.yunti.kdtk.248.tier_38"
    var balance = 0
    
    var productIdentifiers: [String] {
        return [identifier1,
                identifier6,
                identifier18,
                identifier30,
                identifier50,
                identifier93,
                identifier168,
                identifier248]
    }
    let product =  SKProduct()
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerNibOf(TopUpHeaderCell.self)
            tableView.registerNibOf(TopUpNumCell.self)
            tableView.backgroundColor = LLbg
            tableView.separatorStyle = UITableViewCellSeparatorStyle.none
            tableView.showsVerticalScrollIndicator = false
        }
    }
    
    var index = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "充值中心"
        balanceRequest()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @IBAction func TopUpClick(_ sender: Any) {
        if index == 0 {
            LLHUBErr("请选择充值金额！")
            return
        }
        
//        NetworkActivityIndicatorManager.networkOperationStarted()
//        SwiftyStoreKit.retrieveProductsInfo([productIdentifiers[index - 1]]) { result in
//            NetworkActivityIndicatorManager.networkOperationFinished()
//            
//            self.showAlert(self.alertForProductRetrievalInfo(result))
//        }
//        IAPStoreObserver.sharedObserver.buy(product)
        
        
//        SVProgressHUD.show
        NetworkActivityIndicatorManager.networkOperationStarted()
        SwiftyStoreKit.purchaseProduct(productIdentifiers[index - 1], atomically: true) { result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            if case .success(let purchase) = result {
                println(result)
//                self.verifyReceipt { result in
//                    NetworkActivityIndicatorManager.networkOperationFinished()
//                    self.showAlert(self.alertForVerifyReceipt(result))
//                }
                let str = SwiftyStoreKit.localReceiptData?.base64EncodedString()
                println(str ?? "")
                self.requsetIapPaid(str!)
//                IapPaid
                
                if purchase.needsFinishTransaction {
                    SwiftyStoreKit.finishTransaction(purchase.transaction)
                }
            }
            if let alert = self.alertForPurchaseResult(result) {
                self.showAlert(alert)
            }
            
        }
        
        
    }
    
    //充值
    func requsetIapPaid(_ strBase64 : String) {
//        let parameter = IapPaidParameter()
//        parameter.receipt =  strBase64
//        let request = IapPaidRequest(parameter: parameter)
//        request.starRequest(completionHandler: { [unowned self] (model) in
//            self.balance = model
//            self.tableView.reloadData()
//            }, failedHandler: defaultFailureHandler)
    }
    // 个人账户信息
    private func balanceRequest() {
//        let request = MemberBalanceRequest()
//        request.starRequest(completionHandler: {  (Model)  in
//           self.balance = Model.balance
//           self.tableView.reloadData()
//        }, failedHandler: defaultFailureHandler)
    }
}
// MARK: - UITableViewDataSource
extension TopUpVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 120
        }
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: TopUpHeaderCell = tableView.dequeueReusableCell()
            cell.selectionStyle = UITableViewCellSelectionStyle.none
           

//            if  !isShenHe(){
//                let headerImageUrl = "http://img.koudaitiku.com/ios_prep.png"
//                cell.headerImageView.kf.setImage(with: URL.init(string: headerImageUrl), placeholder: #imageLiteral(resourceName: "placeholder"))
//            }else{
//                let headerImageUrl = "http://img.koudaitiku.com/ios_formal.png"
//                cell.headerImageView.kf.setImage(with: URL.init(string: headerImageUrl), placeholder: #imageLiteral(resourceName: "placeholder"))
//            }
            cell.numLable.text = "充值金额（当前余额：\(self.balance/100)元）"
            return cell
        }
        let cell: TopUpNumCell = tableView.dequeueReusableCell()
        cell.setTypeCell(indexPath.row)
        if index == indexPath.row  {
            cell.btn.isSelected = true
        }else{
            cell.btn.isSelected = false
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0  {
            index = indexPath.row
            self.tableView.reloadData()
        }
    }
    
}

// MARK: User facing alerts
extension TopUpVC {
    
    func verifyReceipt(completion: @escaping (VerifyReceiptResult) -> Void) {
        #if DEBUG
            let appleValidator = AppleReceiptValidator(service: .sandbox)
        #else
            let appleValidator = AppleReceiptValidator(service: .production)
        #endif
        let password = "your-shared-secret"
        SwiftyStoreKit.verifyReceipt(using: appleValidator, password: password, completion: completion)
    }
    
    func verifyPurchase(_ productId : String) {
        
        NetworkActivityIndicatorManager.networkOperationStarted()
        verifyReceipt { result in
            NetworkActivityIndicatorManager.networkOperationFinished()
            
            switch result {
            case .success(let receipt):
                let purchaseResult = SwiftyStoreKit.verifyPurchase(
                    productId: productId,
                    inReceipt: receipt
                )
                self.showAlert(self.alertForVerifyPurchase(purchaseResult))
            case .error:
                self.showAlert(self.alertForVerifyReceipt(result))
            }
        }
    }

    
    
    func alertWithTitle(_ title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
    
    func showAlert(_ alert: UIAlertController) {
        guard self.presentedViewController != nil else {
            self.present(alert, animated: true, completion: nil)
            return
        }
    }
    
    func alertForProductRetrievalInfo(_ result: RetrieveResults) -> UIAlertController {
        
        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        } else if let invalidProductId = result.invalidProductIDs.first {
            return alertWithTitle("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)")
        } else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
            return alertWithTitle("Could not retrieve product info", message: errorString)
        }
    }
    
    // swiftlint:disable cyclomatic_complexity
    func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController? {
        switch result {
        case .success(let purchase):
            print("Purchase Success: \(purchase.productId)")
            return alertWithTitle("Thank You", message: "Purchase completed")
        case .error(let error):
            print("Purchase Failed: \(error)")
            switch error.code {
            case .unknown: return alertWithTitle("Purchase failed", message: "Unknown error. Please contact support")
            case .clientInvalid: // client is not allowed to issue the request, etc.
                return alertWithTitle("Purchase failed", message: "Not allowed to make the payment")
            case .paymentCancelled: // user cancelled the request, etc.
                return nil
            case .paymentInvalid: // purchase identifier was invalid, etc.
                return alertWithTitle("Purchase failed", message: "The purchase identifier was invalid")
            case .paymentNotAllowed: // this device is not allowed to make the payment
                return alertWithTitle("Purchase failed", message: "The device is not allowed to make the payment")
            case .storeProductNotAvailable: // Product is not available in the current storefront
                return alertWithTitle("Purchase failed", message: "The product is not available in the current storefront")
            case .cloudServicePermissionDenied: // user has not allowed access to cloud service information
                return alertWithTitle("Purchase failed", message: "Access to cloud service information is not allowed")
            case .cloudServiceNetworkConnectionFailed: // the device could not connect to the nework
                return alertWithTitle("Purchase failed", message: "Could not connect to the network")
            case .cloudServiceRevoked: // user has revoked permission to use this cloud service
                return alertWithTitle("Purchase failed", message: "Cloud service was revoked")
            }
        }
    }
    
    func alertForRestorePurchases(_ results: RestoreResults) -> UIAlertController {
        
        if results.restoreFailedPurchases.count > 0 {
            print("Restore Failed: \(results.restoreFailedPurchases)")
            return alertWithTitle("Restore failed", message: "Unknown error. Please contact support")
        } else if results.restoredPurchases.count > 0 {
            print("Restore Success: \(results.restoredPurchases)")
            return alertWithTitle("Purchases Restored", message: "All purchases have been restored")
        } else {
            print("Nothing to Restore")
            return alertWithTitle("Nothing to restore", message: "No previous purchases were found")
        }
    }
    
    func alertForVerifyReceipt(_ result: VerifyReceiptResult) -> UIAlertController {
        
        switch result {
        case .success(let receipt):
            print("Verify receipt Success: \(receipt)")
            return alertWithTitle("Receipt verified", message: "Receipt verified remotely")
        case .error(let error):
            print("Verify receipt Failed: \(error)")
            switch error {
            case .noReceiptData:
                return alertWithTitle("Receipt verification", message: "No receipt data. Try again.")
            case .networkError(let error):
                return alertWithTitle("Receipt verification", message: "Network error while verifying receipt: \(error)")
            default:
                return alertWithTitle("Receipt verification", message: "Receipt verification failed: \(error)")
            }
        }
    }
    
    func alertForVerifySubscription(_ result: VerifySubscriptionResult) -> UIAlertController {
        
        switch result {
        case .purchased(let expiryDate):
            print("Product is valid until \(expiryDate)")
            return alertWithTitle("Product is purchased", message: "Product is valid until \(expiryDate)")
        case .expired(let expiryDate):
            print("Product is expired since \(expiryDate)")
            return alertWithTitle("Product expired", message: "Product is expired since \(expiryDate)")
        case .notPurchased:
            print("This product has never been purchased")
            return alertWithTitle("Not purchased", message: "This product has never been purchased")
        }
    }
    
    func alertForVerifyPurchase(_ result: VerifyPurchaseResult) -> UIAlertController {
        
        switch result {
        case .purchased:
            print("Product is purchased")
            return alertWithTitle("Product is purchased", message: "Product will not expire")
        case .notPurchased:
            print("This product has never been purchased")
            return alertWithTitle("Not purchased", message: "This product has never been purchased")
        }
    }
}



