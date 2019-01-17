//
//  QuickViewVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import Koloda
class QuickViewVC: UIViewController{
    var titarr = [#imageLiteral(resourceName: "default_user_square"),#imageLiteral(resourceName: "default_user_square"),#imageLiteral(resourceName: "default_user_square")]
    var nearByData : [NearBySearch]!
    var currentIndex = Int()
    
    @IBOutlet weak var carouselView: iCarousel!
    @IBOutlet weak var mDetailview: UIView!
    @IBOutlet weak var KolodaView: KolodaView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        KolodaView.delegate = self
        KolodaView.dataSource = self
        
        carouselView.type = .rotary
        carouselView.isPagingEnabled = true
        self.nearByData = [NearBySearch]()
        currentIndex = 0
        print(nearByData.count)
        if Constants.kUserDefaults.value(forKey:appConstants.selecttype) != nil{
            let type =  Constants.kUserDefaults.value(forKey:appConstants.selecttype)as! String
            getallUsers(type: "?gender=\(type)")
        }else{
            getallUsers(type: "")
        }
    }
  
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func mBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mNextViewBtnAct(_ sender: Any) {
        KolodaView.swipe(.left)
        //  self.carouselView.scrollToItem(at: currentIndex + 1, animated: true)
    }
    
    @IBAction func mMessageBtnAct(_ sender: UIButton) {
        KolodaView.swipe(.right)
        // currentIndex -= currentIndex
        //        print(currentIndex)
        //        print(nearByData.count)
        //        let otherUserId = self.nearByData[currentIndex].id
        //        let otherUsername = self.nearByData[currentIndex].name
        //        print(currentIndex)
        //        let vc  = storyboard?.instantiateViewController(withIdentifier: "UserTakeQuizVCID")as! UserTakeQuizVC
        //        vc.opponentID = otherUserId!
        //        vc.opponentName = otherUsername!
        //        if self.nearByData[currentIndex].imgUrl != nil{
        //            let otherImgUrl = self.nearByData[currentIndex].imgUrl
        //            vc.opponentImgUrl = otherImgUrl!
        //        }
        //        navigationController?.pushViewController(vc, animated: true)
    }
    func getallUsers(type:String) {
        // self.showProgress(title: "Processing")
        SVProgressHUD.show()
        UserAPI().getAllUsers(type: type){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                SVProgressHUD.dismiss()
                if error == nil{
                    //                    self.hideProgress()
                    self.nearByData.removeAll()
                    let nearlist = data[APIConstants.items.rawValue] as! NSArray
                    //                    //   self.postArry = [Post]()
                    //
                    self.nearByData = NearBySearch.modelsFromDictionaryArray(array: nearlist)
                    //
                    //  self.carouselView.reloadData()
                    self.KolodaView.reloadData()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
            SVProgressHUD.dismiss()
        }
    }
}

extension QuickViewVC : iCarouselDataSource,iCarouselDelegate{
    func numberOfItems(in carousel: iCarousel) -> Int {
        if self.nearByData != nil{
            return self.nearByData.count
        }else{
            return 0
        }
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var labelname : UILabel
        var mdeslbl : UILabel
        var itemView: UIImageView
        var mTitleImageView: UIImageView
        var mdollarImageView: UIImageView
        var mTimeImage: UIImageView
        var mLocationImage: UIImageView
        var mlinelbl : UILabel
        var mdollarlbl : UILabel
        var mtimelbl : UILabel
        var mlocationlbl : UILabel
        var mProfileImage: UIImageView
        if (view == nil)
        {
            // main back image
            itemView = UIImageView(frame:CGRect(x:0, y:0, width:carouselView.frame.size.width, height:carouselView.frame.size.height))
            itemView.backgroundColor = .white
            itemView.borderColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
            itemView.borderWidth = 1
            itemView.layer.cornerRadius = 8
            // title image
            mTitleImageView = UIImageView(frame:CGRect(x:0, y:0, width:carouselView.frame.size.width, height:carouselView.frame.size.height/2))
            
            let url = self.nearByData[index].imgUrl
            if url != nil{
                let urlimage = URL(string: url!)
                mTitleImageView.sd_setImage(with: urlimage, placeholderImage: #imageLiteral(resourceName: "default_user_square"))
            }else{
                mTitleImageView.image = #imageLiteral(resourceName: "default_user_square")
            }
            mTitleImageView.contentMode = .scaleAspectFit
            itemView.addSubview(mTitleImageView)
            
            // title name lbl
            labelname = UILabel(frame:CGRect(x: mTitleImageView.center.x - 100  ,y:mTitleImageView.frame.size.height + 10 ,width:200 ,height:21))
            labelname.textAlignment = .center
            labelname.text = self.nearByData[index].name
            labelname.font = labelname.font.withSize(20)
            labelname.textColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
            itemView.addSubview(labelname)
            
            mdeslbl = UILabel(frame:CGRect(x: mTitleImageView.center.x - 150,y:mTitleImageView.frame.size.height + labelname.frame.size.height + 10 ,width:300 ,height:50))
            mdeslbl.textAlignment = .center
            mdeslbl.textColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
            mdeslbl.lineBreakMode = .byWordWrapping
            mdeslbl.numberOfLines = 0
            //   mdeslbl.backgroundColor = .blue
            mdeslbl.text = self.nearByData[index].aboutUs
            itemView.addSubview(mdeslbl)
            
            // single line label
            mlinelbl = UILabel(frame:CGRect(x: mTitleImageView.center.x - carouselView.frame.size.width/2 + 7,y:mTitleImageView.frame.size.height + labelname.frame.size.height + mdeslbl.frame.size.height + 15 ,width:carouselView.frame.size.width - 15 ,height:1))
            mlinelbl.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
            itemView.addSubview(mlinelbl)
            // dollar image
            mdollarImageView = UIImageView(frame:CGRect(x:13, y:itemView.frame.origin.y + mTitleImageView.frame.size.height + labelname.frame.size.height +  mdeslbl.frame.size.height + mlinelbl.frame.size.height + 30, width:19, height:19))
            mdollarImageView.image = #imageLiteral(resourceName: "moenybag")
            mdollarImageView.contentMode = .scaleAspectFit
            itemView.addSubview(mdollarImageView)
            
            // timeimage
            mTimeImage = UIImageView(frame:CGRect(x:13, y:itemView.frame.origin.y + mTitleImageView.frame.size.height + labelname.frame.size.height +  mdeslbl.frame.size.height + mlinelbl.frame.size.height + 30 + mdollarImageView.frame.size.height + 8, width:19, height:19))
            mTimeImage.image = #imageLiteral(resourceName: "clockicon")
            mTimeImage.contentMode = .scaleAspectFit
            itemView.addSubview(mTimeImage)
            
            // location image
            mLocationImage = UIImageView(frame:CGRect(x:13, y:itemView.frame.origin.y + mTitleImageView.frame.size.height + labelname.frame.size.height +  mdeslbl.frame.size.height + mlinelbl.frame.size.height + 30 + mdollarImageView.frame.size.height + 8 + mTimeImage.frame.size.height + 8, width:19, height:19))
            mLocationImage.image = #imageLiteral(resourceName: "pinpoint")
            mLocationImage.contentMode = .scaleAspectFit
            itemView.addSubview(mLocationImage)
            
            // dollor label
            mdollarlbl = UILabel(frame:CGRect(x: itemView.frame.origin.x + mdollarImageView.frame.origin.x + mdollarImageView.frame.size.width + 5 ,y: mdollarImageView.frame.origin.y + mdollarImageView.frame.size.height/2 - 10,width:200 ,height:21))
            mdollarlbl.textAlignment = .left
            mdollarlbl.lineBreakMode = .byWordWrapping
            mdollarlbl.numberOfLines = 0
            mdollarlbl.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            //    mdollarlbl.backgroundColor = .blue
            if self.nearByData[index].question?.count != 0 {
                  mdollarlbl.text = self.nearByData[index].question?[0]
            }
            
            else if self.nearByData[index].question?.count == 0 {
                 mdollarlbl.text = ""
            }
            
          
            itemView.addSubview(mdollarlbl)
            
            // time label
            mtimelbl = UILabel(frame:CGRect(x: itemView.frame.origin.x + mTimeImage.frame.origin.x + mTimeImage.frame.size.width + 5 ,y: mTimeImage.frame.origin.y + mTimeImage.frame.size.height/2 - 10,width:200 ,height:21))
            mtimelbl.textAlignment = .left
            mtimelbl.lineBreakMode = .byWordWrapping
            mtimelbl.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            mtimelbl.numberOfLines = 0
            mtimelbl.text = String(describing:self.nearByData[index].ageGroup)
            itemView.addSubview(mtimelbl)
            
            // location label
            mlocationlbl = UILabel(frame:CGRect(x: itemView.frame.origin.x + mLocationImage.frame.origin.x + mLocationImage.frame.size.width + 5 ,y: mLocationImage.frame.origin.y + mLocationImage.frame.size.height/2 - 10,width:200 ,height:21))
            mlocationlbl.textAlignment = .left
            mlocationlbl.lineBreakMode = .byWordWrapping
            mlocationlbl.numberOfLines = 0
            mlocationlbl.textColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
            //    mlocationlbl.backgroundColor = .blue
            mlocationlbl.text = self.nearByData[index].address
            itemView.addSubview(mlocationlbl)
            
            // location image
            mProfileImage = UIImageView(frame:CGRect(x:itemView.frame.origin.x + itemView.frame.size.width - 70, y:itemView.frame.origin.y + mTitleImageView.frame.size.height + labelname.frame.size.height +  mdeslbl.frame.size.height + mlinelbl.frame.size.height + 25, width:50, height:50))
            //    mProfileImage.image = #imageLiteral(resourceName: "default_user_square")
            if self.nearByData[index].profileType == "novice"{
                mProfileImage.image = #imageLiteral(resourceName: "novicesmall")
            }else if self.nearByData[index].profileType == "proficent"{
                mProfileImage.image = #imageLiteral(resourceName: "proficentsmall")
            }else{
                mProfileImage.image = #imageLiteral(resourceName: "expertsmall")
            }
            //  mProfileImage.backgroundColor = .black
            mProfileImage.contentMode = .scaleAspectFit
            itemView.addSubview(mProfileImage)
        }
        else
        {
            itemView = view as! UIImageView;
            
        }
        
        itemView.backgroundColor = .white
        return itemView
    }
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        print(carousel.currentItemIndex)
        currentIndex = carousel.currentItemIndex
    }
}
extension QuickViewVC: KolodaViewDelegate {
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        KolodaView.resetCurrentCardIndex()
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        //   UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    func koloda(_ koloda: KolodaView, didSwipeCardAt index: Int, in direction: SwipeResultDirection) {
        if direction == SwipeResultDirection.right{
            let otherUserId = self.nearByData[index].id
            print(otherUserId!)
            let otherUsername = self.nearByData[index].name
            print(otherUsername!)
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserTakeQuizVCID")as! UserTakeQuizVC
            vc.opponentID = otherUserId!
            vc.opponentName = otherUsername!
            if self.nearByData[index].imgUrl != nil{
                let otherImgUrl = self.nearByData[index].imgUrl
                vc.opponentImgUrl = otherImgUrl!
            }
            navigationController?.pushViewController(vc, animated: true)
            
        }else{
            
            
        }
    }
}
extension QuickViewVC: KolodaViewDataSource {
    
    func kolodaNumberOfCards(_ koloda:KolodaView) -> Int {
        if self.nearByData != nil{
            return self.nearByData.count
        }else{
            return 0
        }
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .fast
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        let vc  = self.storyboard?.instantiateViewController(withIdentifier: "CardVC") as! CardVC
        //addChildViewController(vc)
        self.addChildViewController(vc)
        koloda.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
        let url = self.nearByData[index].imgUrl
        if url != nil{
            let urlimage = URL(string: url!)
            vc.mProfileimg.sd_setImage(with: urlimage, placeholderImage: #imageLiteral(resourceName: "default_user_square"))
        }else{
            vc.mProfileimg.image = #imageLiteral(resourceName: "default_user_square")
        }
        vc.mtitleNamelbl.text = self.nearByData[index].name
        vc.maboutlbl.text = self.nearByData[index].aboutUs
        if self.nearByData[index].question?.count != 0 {
             vc.mReallbl.text = self.nearByData[index].question?[0]
        }
        
        else if self.nearByData[index].question?.count == 0  {
            vc.mReallbl.text = ""
        }
       
        vc.mAgelbl.text = String(describing:self.nearByData[index].ageGroup)
        vc.mAddresslbl.text = self.nearByData[index].address
        if self.nearByData[index].profileType == "novice"{
            vc.mproficientlbl.image = #imageLiteral(resourceName: "novicesmall")
        }else if self.nearByData[index].profileType == "proficent"{
            vc.mproficientlbl.image = #imageLiteral(resourceName: "proficentsmall")
        }else{
            vc.mproficientlbl.image = #imageLiteral(resourceName: "expertsmall")
        }
        return vc.view
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)![0] as? OverlayView
    }
}

