//
//  PayquizVC.swift
//  Finlit
//
//  Created by Tech Farmerz on 28/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class PayquizVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mCancelBtnAct(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func mPayNowBtn(_ sender: Any) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "QuickQuizVCID") as! QuickQuizVC
            destinationvc.VCcheck = 0
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
    

}
