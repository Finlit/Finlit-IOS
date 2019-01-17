//
//  WhatsTableViewCell.swift
//  Finlit
//
//  Created by Tech Farmerz on 28/11/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class WhatsTableViewCell: UITableViewCell {

    @IBOutlet weak var mDonebtn: UIButton!
    @IBOutlet weak var mCancelBtn: UIButton!
    @IBOutlet weak var mImg: UIImageView!
    @IBOutlet weak var mlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
