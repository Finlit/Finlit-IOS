//
//  HomeVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate {
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        print("Paypal Cancel Payment")
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable : Any]) {
        print("Paypal Payment logincerdential")
    }
    
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }

    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default
    
    
    
    var mBool = Bool()
    @IBOutlet weak var mVerlbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
    
        // Set up payPalConfig
        payPalConfig.acceptCreditCards = false
        payPalConfig.merchantName = "Awesome Shirts, Inc."
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
        payPalConfig.payPalShippingAddressOption = .payPal;
        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
    
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        mBool = true
         mVerlbl.isHidden = true

    }
    @IBAction func mDatesBtnAct(_ sender: Any) {
        
                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "SplashVCID") as! SplashVC
                self.navigationController?.pushViewController(destinationvc, animated: true)
//        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "MatchesVCID") as! MatchesVC
//        destinationvc.VCcheckInt = 0
//        self.navigationController?.pushViewController(destinationvc, animated: true)
        
    }
    
    @IBAction func mVersionBtnAct(_ sender: Any) {
        if mBool == true{
            mVerlbl.isHidden = false
             mBool = false
        }else{
            mVerlbl.isHidden = true
             mBool = true
        }
        
    }
    
    @IBAction func mMessagebtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVCID") as! ChatVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
        
    }
    
    @IBAction func mMyBlogsBtn(_ sender: UIButton) {
                let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "MyBlogsVCID") as! MyBlogsVC
                self.navigationController?.pushViewController(destinationvc, animated: true)

    }
    
    
    
    @IBAction func mNearByBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "NearByVCID") as! NearByVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    @IBAction func mChatBtn(_ sender: UIButton) {
        let resultController = self.storyboard?.instantiateViewController(withIdentifier: "popupID") as? UINavigationController
        self.navigationController?.definesPresentationContext = true
        resultController?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        resultController?.modalTransitionStyle = .crossDissolve
        self.present(resultController!, animated: true, completion: nil)
        
        
        
        
        
        // Remove our last completed payment, just for demo purposes.
        resultText = ""
        // Optional: include multiple items
//        let item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 1, withPrice: NSDecimalNumber(string: "84.99"), withCurrency: "USD", withSku: "Hip-0037")
//        let item2 = PayPalItem(name: "Free rainbow patch", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.00"), withCurrency: "USD", withSku: "Hip-00066")
//        let item3 = PayPalItem(name: "Long-sleeve plaid shirt (mustache not included)", withQuantity: 1, withPrice: NSDecimalNumber(string: "37.99"), withCurrency: "USD", withSku: "Hip-00291")
//        let items = [item1, item2, item3]
//        let subtotal = PayPalItem.totalPrice(forItems: items)
//        // Optional: include payment details
//        let shipping = NSDecimalNumber(string: "5.99")
//        let tax = NSDecimalNumber(string: "2.50")
//        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
//        let total = subtotal.adding(shipping).adding(tax)
//        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Hipster Clothing", intent: .sale)
//        payment.items = items
//        payment.paymentDetails = paymentDetails
//        if (payment.processable) {
//            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
//            present(paymentViewController!, animated: true, completion: nil)
//        }
//        else {
//            print("Payment not processalbe: \(payment)")
//        }
    }
    
    
    
    
    
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        resultText = ""
        //successView.isHidden = true
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            self.resultText = completedPayment.description
            //self.showSuccess()
        })
    }
    
    func payPalFuturePaymentDidCancel(_ futurePaymentViewController: PayPalFuturePaymentViewController) {
        print("PayPal Future Payment Authorization Canceled")
        //successView.isHidden = true
        futurePaymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalFuturePaymentViewController(_ futurePaymentViewController: PayPalFuturePaymentViewController, didAuthorizeFuturePayment futurePaymentAuthorization: [AnyHashable: Any]) {
        print("PayPal Future Payment Authorization Success!")
        // send authorization to your server to get refresh token.
        futurePaymentViewController.dismiss(animated: true, completion: { () -> Void in
            self.resultText = futurePaymentAuthorization.description
            //self.showSuccess()
        })
    }
    
    @IBAction func mPendingDatesBtn(_ sender: UIButton) {
               let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "PendingDatesVCID") as! PendingDatesVC
                self.navigationController?.pushViewController(destinationvc, animated: true)
        
    }
    
    @IBAction func mSubscriptionsBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionsVCID") as! SubscriptionsVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    @IBAction func mMyProfileBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "UserProfileVCID") as! UserProfileVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    @IBAction func mSettingBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "SettingVCID") as! SettingVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    @IBAction func mNotificationBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationVCID") as! NotificationVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    
    @IBAction func mShareNow(_ sender: UIButton) {
        // text to share
        let text = "Share"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won’t crash
        
        //            // exclude some activity types from the list (optional)
        //            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
}
extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
