//
//  NotificationTblCell.swift
//  Finlit
//
//  Created by Gurpreet Singh on 16/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class NotificationTblCell: UITableViewCell {

    @IBOutlet weak var mView: UIView!
    @IBOutlet weak var mImageView: UIImageView!
    
    @IBOutlet weak var mLabel: UILabel!
    
    @IBOutlet weak var mSwipeToReactLbl: UILabel!
    
    @IBOutlet weak var mYesterdayLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
