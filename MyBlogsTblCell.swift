//
//  MyBlogsTblCell.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 13/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit




protocol MyBlogsTblCellDelegate: NSObjectProtocol {
    func exampleTableViewCellDidTapPurchaseButton(_ cell: MyBlogsTblCell?)
}



class MyBlogsTblCell: UITableViewCell {
    

    
    weak var delegate: MyBlogsTblCellDelegate?
    
    var isExpanded: Bool = false


    @IBOutlet weak var mHeadlineLbl: UILabel!
    @IBOutlet weak var mUserImgView: UIImageView!
    @IBOutlet weak var mAuthorLbl: UILabel!
    @IBOutlet weak var mDescriptionLbl: UILabel!
    @IBOutlet weak var mBlogImgView: UIImageView!
    @IBOutlet weak var mHeartImgView: UIImageView!
    
    @IBOutlet weak var mLikeBtn: UIButton!
    @IBOutlet weak var mShareBtn: UIButton!
    @IBOutlet weak var mCommentsBtn: UIButton!
    
    @IBOutlet weak var mCommentsLbl: UILabel!
    @IBOutlet weak var mLikeLbl: UILabel!
    
 
    
    
    
   
    
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        mUserImgView.layer.cornerRadius = mUserImgView.frame.height/2
        
    
        mDescriptionLbl.adjustsFontSizeToFitWidth = false
        mDescriptionLbl.lineBreakMode = .byTruncatingTail
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    

    

}
