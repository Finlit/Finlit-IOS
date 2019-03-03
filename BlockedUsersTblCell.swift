//
//  BlockedUsersTblCell.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class BlockedUsersTblCell: UITableViewCell {

    @IBOutlet weak var mNameLbl: UILabel!
    @IBOutlet weak var mIntrestLbl: UILabel!
    @IBOutlet weak var mUserImg: UIImageView!
    @IBOutlet weak var mUnblockBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mUserImg.contentMode = .scaleToFill

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
