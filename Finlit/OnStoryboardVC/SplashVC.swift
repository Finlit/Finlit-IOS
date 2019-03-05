//
//  SplashVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 08/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
                        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "DatesVCID") as! DatesVC
                        self.navigationController?.pushViewController(destinationvc, animated: true)
            

        }
     
    }
    



}
