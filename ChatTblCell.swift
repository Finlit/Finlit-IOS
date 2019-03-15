//
//  ChatTblCell.swift
//  Finlit
//
//  Created by Gurpreet Singh on 16/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ChatTblCell: UITableViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mNameLbl: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mLabel1: UILabel!
    @IBOutlet weak var mTimeLbl: UILabel!
    @IBOutlet weak var mView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
   
        mImageView.contentMode = .scaleToFill
        mImageView.clipsToBounds = true
        
        
        
        // *** Set masks bounds to NO to display shadow visible ***
        self.mView.layer.masksToBounds = false
        // *** Set light gray color as shown in sample ***
        self.mView.layer.shadowColor = UIColor.lightGray.cgColor
        // *** *** Use following to add Shadow top, left ***
//        self.mView.layer.shadowOffset = CGSizeMake(-5.0, -5.0)
        
        // *** Use following to add Shadow bottom, right ***
//        self.mView.layer.shadowOffset = CGSizeMake(5.0, 5.0)
        
        // *** Use following to add Shadow top, left, bottom, right ***
         mView.layer.shadowOffset = .zero
         mView.layer.shadowRadius = 5.0
        
        // *** Set shadowOpacity to full (1) ***
        self.mView.layer.shadowOpacity = 1.0
     
        
        
    
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
