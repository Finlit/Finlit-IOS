//
//  MyBlogsVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 13/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit
import HVTableView
import Toast_Swift

class MyBlogsVC: UIViewController {

    @IBOutlet weak var mBlogHVTbl: HVTableView!
    @IBOutlet weak var mBlogsTblView: UITableView!
    var blogsModelArray = [Blog]()
    var labelHeight : CGFloat = 0
    var selectedCellIndex : IndexPath?
    var descriptlblWidth : CGFloat = 0
    var descriptionStringArry = [String]()
      var refreshControl = UIRefreshControl()
     var deviceModelName : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptlblWidth = self.view.bounds.width - 20
          self.blogsModelArray = [Blog]()
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        mBlogsTblView.addSubview(refreshControl)
        self.checkDeviceModel()
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
     
   
     
        DispatchQueue.global(qos: .background).async {
            self.getAllBlogs()
        }
       
    }
    
    
    
    @objc func refresh(sender:AnyObject) {
        self.getAllBlogs()
        
    }
    
    
    func checkDeviceModel () {
        self.deviceModelName = UIDevice.current.modelName
        print ("Device Model is \(deviceModelName)")
    }
    

    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: Get All Blogs
    func getAllBlogs(name:String = "") {
        
        QuestionAPI().getAllBlogs(name: name,pageNo: 0) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {

                if error == nil{
                    
                    self.refreshControl.endRefreshing()
                    let blogList = data[APIConstants.items.rawValue] as! NSArray
                    self.blogsModelArray = Blog.modelsFromDictionaryArray(array: blogList)
                    self.mBlogsTblView.delegate = self
                    self.mBlogsTblView.dataSource = self
//                    self.mBlogHVTbl.hvTableViewDelegate = self
//                    self.mBlogHVTbl.hvTableViewDataSource = self
                    
                    
                  self.mBlogsTblView.reloadData()
                    
                }}
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
}
    

extension MyBlogsVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.blogsModelArray.count == 0 || self.blogsModelArray.isEmpty == true  {
            self.mBlogsTblView.setEmptyMessage("No Blogs Yet", tablename: self.mBlogsTblView)
        }
            
            
        else {
            self.mBlogsTblView.restore()
        }
        
        return self.blogsModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBlogsTblCellID", for: indexPath) as! MyBlogsTblCell
        //self.labelHeight = cell.mDescriptionLbl.bounds.size.height
        cell.selectionStyle = .none
        let blog = self.blogsModelArray[indexPath.row]
        //let lblwidth = self.view.bounds.width - 20
        self.labelHeight = (blog.description?.heightWithConstrainedWidth(width: self.descriptlblWidth, font: UIFont.systemFont(ofSize: 14)))!
        cell.mHeadlineLbl.text = blog.title
        cell.mDescriptionLbl.text = blog.description
        
 
    
    
  
        if blog.isLike == true {
            cell.mHeartImgView.image = UIImage(named: "filledHeart")
        
        }
        
        else if blog.isLike == false {
            cell.mHeartImgView.image = UIImage(named: "unfilledHeart")
    
        }
        
        if blog.user?.imgUrl != nil {
            cell.mUserImgView.sd_setImage(with: URL.init(string:((blog.user?.imgUrl!.httpsExtend)!)), placeholderImage: #imageLiteral(resourceName: "default_user_square")) }
        if blog.imgUrl != nil {
            cell.mBlogImgView.sd_setImage(with: URL.init(string:(blog.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "default_user_square")) }
        
        
        cell.mLikeLbl.text = "Like " + String(describing:blog.likeCount!)
        cell.mCommentsLbl.text = "Comments " + "(\(String(describing:blog.commentCount!)))"
        cell.mBlogImgView.contentMode = .scaleToFill
        cell.mBlogImgView.clipsToBounds = true
    
        cell.mLikeBtn.tag = indexPath.row
        cell.mShareBtn.tag = indexPath.row
        cell.mCommentsBtn.tag = indexPath.row
        cell.mLikeBtn.addTarget(self, action: #selector(likeBtnAction), for: .touchUpInside)
        cell.mShareBtn.addTarget(self, action: #selector(shareBtnAction), for: .touchUpInside)
        cell.mCommentsBtn.addTarget(self, action: #selector(commentBtnAction), for: .touchUpInside)
       return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let blog = blogsModelArray[indexPath.row]
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentsVCID") as! CommentsVC
        destinationVC.blogID = blog.id!
        self.navigationController?.pushViewController(destinationVC, animated: true)
         self.selectedCellIndex = indexPath
        
        
        
  
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if self.deviceModelName == "iPhone XS Max" {
            
            return 330 + self.labelHeight
        }
          return 320 + labelHeight

    }
    
    

    
    
}



extension MyBlogsVC {
    
    // MARK: Like Function
    func likeBlog(IdOfBLog:String){
     
        QuestionAPI().likeBlog(blogID: IdOfBLog){ (isSuccess, response, error) -> Void in
         
            
            if (isSuccess){
                print("Blog Liked")
               
                self.mBlogsTblView.reloadData()
                
            }else{
               
                if error != nil{
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
        
    }
    
    
    // MARK: DisLike Function
    
    func dislikeBlog(IdOfBLog:String){
        
        QuestionAPI().dislikeBlog(blogID: IdOfBLog){ (isSuccess, response, error) -> Void in
          
            
            if (isSuccess){
                print("blog Disliked")
            
                self.mBlogsTblView.reloadData()
                
            }else{
           
                if error != nil{
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
        
        
    }
    
    
    
    
    @objc func likeBtnAction(sender:UIButton)  {
        let tag = sender.tag
        let blog = blogsModelArray[tag]
        let i = IndexPath(row: tag, section: 0)
        let cell = mBlogsTblView.cellForRow(at: i)  as! MyBlogsTblCell
        if blog.isLike == false{
        let newCount = blog.likeCount! + 1
            blog.isLike = true
            blog.likeCount = newCount
            cell.mHeartImgView.image = UIImage(named: "filledHeart")
        cell.mLikeLbl.text = "Like " + String(describing:newCount)
            self.likeBlog(IdOfBLog: blog.id!)
            
        }
            
   
        else if blog.isLike == true && blog.likeCount != 0 {
            let newCount = blog.likeCount! - 1
            blog.isLike = false
            blog.likeCount = newCount
              cell.mHeartImgView.image = UIImage(named: "unfilledHeart")
            cell.mLikeLbl.text = "Like " + String(describing:newCount)
            self.dislikeBlog(IdOfBLog: blog.id!)}
            
    }
    
    
    @objc func shareBtnAction(sender:UIButton)  {
        // text to share
        let tag = sender.tag
        let blog = blogsModelArray[tag]
        let i = IndexPath(row: tag, section: 0)
        guard let blogLink = blog.link  else {
            return }
        
        // set up activity view controller
        let textToShare = [ blogLink ]
        
        if #available(iOS 11, *) {
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            self.navigationController?.present(activityViewController, animated: true, completion: nil)
        } else {
            self.view.makeToast("To use this feature, update your os")
            return
           
        }
       
       
    }
    
    
    
    @objc func commentBtnAction(sender:UIButton) {
        let tag = sender.tag
        let blog = blogsModelArray[tag]
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentsVCID") as! CommentsVC
        guard let blgId = blog.id else {return}
        destinationVC.blogID = blgId   //blog.id!
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    
    

    
    
        

        
        
    
    
    
    
} //EXTENSION CLOSED


//extension MyBlogsVC : HVTableViewDelegate,HVTableViewDataSource {
//    func tableView(_ tableView: UITableView!, cellForRowAt indexPath: IndexPath!, isExpanded: Bool) -> UITableViewCell! {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyBlogsTblCellID", for: indexPath) as! MyBlogsTblCell
//
//        cell.selectionStyle = .none
//
//        let blog = self.blogsModelArray[indexPath.row]
//
//        self.labelHeight = (blog.description?.heightWithConstrainedWidth(width: self.descriptlblWidth, font: UIFont.systemFont(ofSize: 14)))!
//        cell.mHeadlineLbl.text = blog.title
//        cell.mDescriptionLbl.text = blog.description
//
////        let subSt = blog.description?.prefix(25)
////        cell.mDescriptionLbl.text = String(subSt!)
//
//
//
//
//
//
//
//        if blog.isLike == true {
//            cell.mHeartImgView.image = UIImage(named: "filledHeart")
//
//        }
//
//        else if blog.isLike == false {
//            cell.mHeartImgView.image = UIImage(named: "unfilledHeart")
//
//        }
//
//        if blog.user?.imgUrl != nil {
//            cell.mUserImgView.sd_setImage(with: URL.init(string:((blog.user?.imgUrl!.httpsExtend)!)), placeholderImage: #imageLiteral(resourceName: "portrait2")) }
//        if blog.imgUrl != nil {
//            cell.mBlogImgView.sd_setImage(with: URL.init(string:(blog.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
//
//
//        cell.mLikeLbl.text = "Like " + String(describing:blog.likeCount!)
//        cell.mCommentsLbl.text = "Comments " + "(\(String(describing:blog.commentCount!)))"
//        cell.mBlogImgView.contentMode = .scaleToFill
//        cell.mBlogImgView.clipsToBounds = true
//
//        cell.mLikeBtn.tag = indexPath.row
//        cell.mShareBtn.tag = indexPath.row
//        cell.mCommentsBtn.tag = indexPath.row
//        cell.mLikeBtn.addTarget(self, action: #selector(likeBtnAction), for: .touchUpInside)
//        cell.mShareBtn.addTarget(self, action: #selector(shareBtnAction), for: .touchUpInside)
//        cell.mCommentsBtn.addTarget(self, action: #selector(commentBtnAction), for: .touchUpInside)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView!, collapse cell: UITableViewCell!, with indexPath: IndexPath!) {
////         let blog = self.blogsModelArray[indexPath.row]
////        let cell = tableView.cellForRow(at: indexPath) as! MyBlogsTblCell
////        let subSt = blog.description?.prefix(25)
////        cell.mDescriptionLbl.text = String(subSt!) + "..."
////        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//
//
//    }
//
//    func tableView(_ tableView: UITableView!, expand cell: UITableViewCell!, with indexPath: IndexPath!) {
//
////        let blog = self.blogsModelArray[indexPath.row]
////        let cell = tableView.cellForRow(at: indexPath) as! MyBlogsTblCell
////        cell.mDescriptionLbl.text = blog.description
////        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.fade)
//
//
//    }
//
//
////    func numberOfSections(in tableView: UITableView!) -> Int {
////        return 1
////    }
//
//    func tableView(_ tableView: UITableView!, heightForRowAt indexPath: IndexPath!, isExpanded: Bool) -> CGFloat {
//
//        if self.deviceModelName == "iPhone XS Max" {
//
//             return 350 + self.labelHeight
//        }
//
//        return 340 + self.labelHeight
//
//
//    }
//
//
//}
