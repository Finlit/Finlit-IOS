//
//  PayquizVC.swift
//  Finlit
//
//  Created by Tech Farmerz on 28/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class PayquizVC: UIViewController, PayPalPaymentDelegate, PayPalFuturePaymentDelegate, PayPalProfileSharingDelegate {
    
    var resultText = "" // empty
    var payPalConfig = PayPalConfiguration() // default

    override func viewDidLoad() {
        super.viewDidLoad()

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
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mCancelBtnAct(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mPayNowBtn(_ sender: Any) {
        
        
                let item1 = PayPalItem(name: "Finlit Quiz", withQuantity: 1, withPrice: NSDecimalNumber(string: "1"), withCurrency: "USD", withSku: "Fin-000")
//                let item2 = PayPalItem(name: "Free rainbow patch", withQuantity: 1, withPrice: NSDecimalNumber(string: "0.00"), withCurrency: "USD", withSku: "Hip-00066")
//                let item3 = PayPalItem(name: "Long-sleeve plaid shirt (mustache not included)", withQuantity: 1, withPrice: NSDecimalNumber(string: "37.99"), withCurrency: "USD", withSku: "Hip-00291")
//                let items = [item1, item2, item3]
                 let items = [item1]
                let subtotal = PayPalItem.totalPrice(forItems: items)
                // Optional: include payment details
                let shipping = NSDecimalNumber(string: "5.99")
                let tax = NSDecimalNumber(string: "2.50")
                let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
                let total = subtotal.adding(shipping).adding(tax)
                let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Finlit", intent: .sale)
                payment.items = items
                payment.paymentDetails = paymentDetails
                if (payment.processable) {
                    let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
                    present(paymentViewController!, animated: true, completion: nil)
                }
                else {
                    print("Payment not processalbe: \(payment)")
                }

        
        
        
//        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "QuickQuizVCID") as! QuickQuizVC
//            destinationvc.VCcheck = 0
//        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    
    
    
    
    // PayPalPaymentDelegates
    
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
    
    
    func userDidCancel(_ profileSharingViewController: PayPalProfileSharingViewController) {
        print("Paypal Cancel Payment")
    }
    
    func payPalProfileSharingViewController(_ profileSharingViewController: PayPalProfileSharingViewController, userDidLogInWithAuthorization profileSharingAuthorization: [AnyHashable : Any]) {
        print("Paypal Payment logincredential")
    }
    
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnect(withEnvironment: newEnvironment)
            }
        }
    }
    
    
    

}




