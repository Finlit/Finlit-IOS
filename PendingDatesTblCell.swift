//
//  PendingDatesTblCell.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class PendingDatesTblCell: UITableViewCell {
    
    
    @IBOutlet weak var mConfirmInterestBtn: UIButton!
    @IBOutlet weak var mNoThanksBtn: UIButton!
    @IBOutlet weak var mProfileImgSmall: UIImageView!
    @IBOutlet weak var mProfileImgMain: UIImageView!
    @IBOutlet weak var mInterestLbl: UILabel!
    @IBOutlet weak var mNameAgeLbl: UILabel!
    @IBOutlet weak var mWantsToMeetLbl: UILabel!
    @IBOutlet weak var mPlaceLbl: UILabel!
    @IBOutlet weak var mTimeLbl: UILabel!
    @IBOutlet weak var mCalendarIcon: UIImageView!
    @IBOutlet weak var mLocationIcon: UIImageView!
    @IBOutlet weak var mConfirmBtnTopConst: NSLayoutConstraint!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mConfirmInterestBtn.layer.cornerRadius = 4
        self.mNoThanksBtn.layer.cornerRadius = 4
        mNoThanksBtn.layer.borderWidth = 0.6
        mNoThanksBtn.layer.borderColor = UIColor.lightGray.cgColor
        mProfileImgMain.contentMode = .scaleToFill
        mProfileImgMain.clipsToBounds = true
        mProfileImgSmall.contentMode = .scaleToFill
        mProfileImgSmall.clipsToBounds = true


    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
