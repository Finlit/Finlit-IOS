//
//  MyBlogsVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 13/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class MyBlogsVC: UIViewController {

    @IBOutlet weak var mBlogsTblView: UITableView!
    var blogsModelArray = [Blog]()
    var labelHeight : CGFloat = 0
    var selectedCellIndex : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()
          self.blogsModelArray = [Blog]()
     
     
        
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden = false
     
        DispatchQueue.global(qos: .background).async {
            self.getAllBlogs()
        }
     
        //self.getAllBlogs()
       
    }
    

    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: Get All Blogs
    func getAllBlogs(name:String = "") {
        
        QuestionAPI().getAllBlogs(name: name,pageNo: 0) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {

                if error == nil{
                    
                    let blogList = data[APIConstants.items.rawValue] as! NSArray
                    self.blogsModelArray = Blog.modelsFromDictionaryArray(array: blogList)
                    self.mBlogsTblView.delegate = self
                    self.mBlogsTblView.dataSource = self
//                    mBlogsTblView.estimatedRowHeight = 320
//                    mBlogsTblView.rowHeight = UITableViewAutomaticDimension
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
        
        cell.selectionStyle = .none
        let blog = self.blogsModelArray[indexPath.row]
        cell.mHeadlineLbl.text = blog.title
        cell.mDescriptionLbl.text = blog.description
        self.labelHeight = cell.mDescriptionLbl.bounds.size.height
 
    
    
  
        if blog.isLike == true {
            cell.mHeartImgView.image = UIImage(named: "filledHeart")
        
        }
        
        else if blog.isLike == false {
            cell.mHeartImgView.image = UIImage(named: "unfilledHeart")
    
        }
        
        if blog.user?.imgUrl != nil {
            cell.mUserImgView.sd_setImage(with: URL.init(string:((blog.user?.imgUrl!.httpsExtend)!)), placeholderImage: #imageLiteral(resourceName: "portrait2")) }
        if blog.imgUrl != nil {
            cell.mBlogImgView.sd_setImage(with: URL.init(string:(blog.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
        
        
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
//        let blog = blogsModelArray[indexPath.row]
//        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentsVCID") as! CommentsVC
//        destinationVC.blogID = blog.id!
//        self.navigationController?.pushViewController(destinationVC, animated: true)
        
         self.selectedCellIndex = indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         print("Height of the label is \(self.labelHeight) at indexpath = \(indexPath.row)")
      
          return 300 + labelHeight
    
    }
    
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300 + labelHeight
    }
    
    
}



extension MyBlogsVC {
    
    // MARK: Like Function
    func likeBlog(IdOfBLog:String){
     
        QuestionAPI().likeBlog(blogID: IdOfBLog){ (isSuccess, response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                print("Blog Liked")
                SVProgressHUD.dismiss()
                self.getAllBlogs()
                self.mBlogsTblView.reloadData()
                
            }else{
                SVProgressHUD.dismiss()
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
        //SVProgressHUD.show(withStatus: "Please Wait")
        QuestionAPI().dislikeBlog(blogID: IdOfBLog){ (isSuccess, response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                print("blog Disliked")
                SVProgressHUD.dismiss()
                self.getAllBlogs()
                self.mBlogsTblView.reloadData()
                
            }else{
                SVProgressHUD.dismiss()
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
            blog.likeCount = newCount
            cell.mHeartImgView.image = UIImage(named: "filledHeart")
        cell.mLikeLbl.text = "Like " + String(describing:newCount)
            self.likeBlog(IdOfBLog: blog.id!)
            
        }
            
   
        else if blog.isLike == true && blog.likeCount != 0 {
            let newCount = blog.likeCount! - 1
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
        let text = blog.description
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won’t crash
        
        //            // exclude some activity types from the list (optional)
        //            activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    
    @objc func commentBtnAction(sender:UIButton) {
        let tag = sender.tag
        let blog = blogsModelArray[tag]
        let destinationVC = self.storyboard?.instantiateViewController(withIdentifier: "CommentsVCID") as! CommentsVC
        destinationVC.blogID = blog.id!
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    
    

    
    
        

        
        
    
    
    
    
} //EXTENSION CLOSED
