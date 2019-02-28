//
//  MyBlogsTblCell.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 13/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

protocol MyBlogsTblCellDelegate {
    func moreTapped(cell: MyBlogsTblCell)
}

class MyBlogsTblCell: UITableViewCell {
    
    var delegate: MyBlogsTblCellDelegate?
    
    var isExpanded: Bool = false

    @IBOutlet weak var mReadMoreOutl: UIButton!
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
    
    @IBOutlet weak var mDescriptionHeight: NSLayoutConstraint!
    
    
    @IBAction func mReadMoreBtnAct(_ sender: Any) {
        if sender is UIButton {
            isExpanded = !isExpanded
            
            mDescriptionLbl.numberOfLines = isExpanded ? 0 : 2
            mReadMoreOutl.setTitle(isExpanded ? "Read less..." : "Read more...", for: .normal)
            delegate?.moreTapped(cell: self)
        }
    }
    
    
    
    public func myInit(theTitle: String, theBody: String) {
        
        isExpanded = false
        
        mDescriptionLbl.text = theTitle
        mDescriptionLbl.text = theBody
        
        mDescriptionLbl.numberOfLines = 0
        
        mDescriptionLbl.text = theBody
        mDescriptionLbl.numberOfLines = 2
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mUserImgView.layer.cornerRadius = mUserImgView.frame.height/2
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
