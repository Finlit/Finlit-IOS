//
//  WelcomeVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 09/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var mGetStarted: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mGetStarted.layer.cornerRadius = CGFloat(10)
        self.mGetStarted.clipsToBounds = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func mGetStartedBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "QuickQuizVCID") as! QuickQuizVC
        destinationvc.VCcheck = 1
        self.navigationController?.pushViewController(destinationvc, animated: true)
        
    }
    
    
}
