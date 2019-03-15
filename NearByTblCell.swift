//
//  NearByTblCell.swift
//  Finlit
//
//  Created by Gurpreet Singh on 16/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class NearByTblCell: UITableViewCell {

    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var mImageView1: UIImageView!
    
    @IBOutlet weak var mImageView2: UIImageView!
    
    @IBOutlet weak var mImageView3: UIImageView!
    
    @IBOutlet weak var mNameLbl: UILabel!
    
    @IBOutlet weak var mLabel: UILabel!
    
    @IBOutlet weak var mLabel1: UILabel!
    
    @IBOutlet weak var mMessageBtn: UIButton!
    
    @IBOutlet weak var mViewProfileBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mImageView.contentMode = .scaleToFill
       
 
        self.mView.layer.masksToBounds = false
    
        self.mView.layer.shadowColor = UIColor.lightGray.cgColor

        mView.layer.shadowOffset = .zero
        mView.layer.shadowRadius = 6.0
        
        self.mView.layer.shadowOpacity = 1.5
        self.mView.borderWidth = 0.4
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
