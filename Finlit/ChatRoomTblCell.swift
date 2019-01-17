//
//  ChatRoomTblCell.swift
//  Finlit
//
//  Created by Gurpreet Singh on 23/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ChatRoomTblCell: UITableViewCell {
    
    @IBOutlet weak var mNameLbl: UILabel!
    @IBOutlet weak var mLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
