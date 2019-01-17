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
        // Initialization code
        mImageView.contentMode = .scaleToFill
        mImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
