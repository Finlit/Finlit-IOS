//
//  UserChatRoomTblCell.swift
//  Finlit
//
//  Created by Gurpreet Singh on 23/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class UserChatRoomTblCell: UITableViewCell {
    
    @IBOutlet weak var mSenderImg: UIImageView!
    @IBOutlet weak var mImageView: UIImageView!
    @IBOutlet weak var mUserImage: UIImageView!
    @IBOutlet weak var mLabel: UILabel!
    @IBOutlet weak var mlabel1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
