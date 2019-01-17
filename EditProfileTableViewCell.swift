//
//  EditProfileTableViewCell.swift
//  Finlit
//
//  Created by Tech Farmerz on 07/12/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class EditProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var mtxtfld: UITextField!
    @IBOutlet weak var mCheckbtn: UIButton!
    
    @IBOutlet weak var mDoneBtn: UIButton!
    @IBOutlet weak var mlbl2: UILabel!
    @IBOutlet weak var mImg2: UIImageView!
    @IBOutlet weak var mtoplblConstant: NSLayoutConstraint!
    @IBOutlet weak var mBottomConstant: NSLayoutConstraint!
    
    @IBOutlet weak var mBottomDoneConstant: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
