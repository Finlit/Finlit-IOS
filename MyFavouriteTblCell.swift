//
//  MyFavouriteTblCell.swift
//  Finlit
//
//  Created by Gurpreet Singh on 16/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class MyFavouriteTblCell: UITableViewCell {
    
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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
