//
//  CommentsTblCell.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 28/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class CommentsTblCell: UITableViewCell {

    @IBOutlet weak var mTimeLbl: UILabel!
    @IBOutlet weak var mCommentLbl: UILabel!
    @IBOutlet weak var mNameLbl: UILabel!
    @IBOutlet weak var mUserImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mUserImg.layer.cornerRadius = self.mUserImg.frame.height / 2
        self.mUserImg.clipsToBounds = true
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
