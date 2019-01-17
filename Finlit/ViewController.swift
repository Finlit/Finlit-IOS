//
//  ViewController.swift
//  Finlit
//
//  Created by Gurpreet Singh on 05/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
      
    
      
      
    }

  


  
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mFbButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func mSignupTappedBtn(_ sender: UIButton) {
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVCID") as! SignUpVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
        
    }
    

    
}

