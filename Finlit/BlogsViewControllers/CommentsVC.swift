//
//  CommentsVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 15/02/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit
import Toast_Swift


class CommentsVC: UIViewController {

    @IBOutlet weak var mUserProfPic: UIImageView!
    @IBOutlet weak var mCommentTxtFld: UITextField!
    @IBOutlet weak var mCommentsTblView: UITableView!
    @IBOutlet weak var mDescriptionLbl: UILabel!
    @IBOutlet weak var mHeadlineLbl: UILabel!
    @IBOutlet weak var mBlogImg: UIImageView!
    var blogID : String?
    var blog :Blog?
    var userMdlVar : User?
    var commentMdlVar :Comment!
    var commentModlArry : [Comment]!
    var questionAPI : QuestionAPI!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.questionAPI = QuestionAPI.sharedInstance
        self.commentModlArry = [Comment]()
        setupUI()
        if self.blogID != nil{
            self.getPostDetailsByID(idOfBlog: self.blogID!)}
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        if self.blogID != nil{
            self.getAllComments()
            self.mCommentsTblView.setEmptyMessage("", tablename: mCommentsTblView)
        }
    }
    
    func setupUI(){
        self.mUserProfPic.layer.cornerRadius = self.mUserProfPic.frame.height / 2
        self.mUserProfPic.clipsToBounds = true
        if fetchProfileFromPresistance() == true{
            if self.userMdlVar!.imgUrl != nil {
                self.mUserProfPic.sd_setImage(with: URL.init(string:(self.userMdlVar!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
            
        }
        
        else {
            if let userid = Constants.kUserDefaults.value(forKey: appConstants.userId){
                self.getUserDetail(UserID: userid as! String)
            }}
    }
    
    
    
    func fetchProfileFromPresistance() -> Bool {
        if let profile = UserDefaults.standard.data(forKey: appConstants.profile){
            let userDict = NSKeyedUnarchiver.unarchiveObject(with: profile)
            let myProfile = User.init(dictionary: userDict as! NSDictionary)
            self.userMdlVar = myProfile
            return true
        }
        
        
        return false
        
    }

    
    
    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func mSendBtnTapped(_ sender: UIButton) {
        self.commentMdlVar = Comment.init(dictionary: NSDictionary())
        if self.mCommentTxtFld.text != nil || self.mCommentTxtFld.text != "" {
            commentMdlVar.text = self.mCommentTxtFld.text
            commentMdlVar.blogId = self.blogID
             self.createComment(commentDict: commentMdlVar!)
            
        }
        
    }
    
    
    
    
    
    //MARK: Get Post Details By Id
    func getPostDetailsByID(idOfBlog:String) {
        questionAPI.getBlogDetailsById(blogId: idOfBlog) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                let postData = data[APIConstants.data.rawValue] as! NSDictionary
                self.blog = Blog.init(dictionary: postData)
                self.mHeadlineLbl.text = self.blog?.title
                self.mDescriptionLbl.text = self.blog?.description
                if self.blog!.imgUrl != nil {
                    self.mBlogImg.sd_setImage(with: URL.init(string:(self.blog!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
            }
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    //MARK: Get All Comments
    func getAllComments() {
        questionAPI.getCommentsOfBlog(blogId: self.blogID!) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let postList = data[APIConstants.items.rawValue] as! NSArray
                    self.commentModlArry = Comment.modelsFromDictionaryArray(array: postList)
                    //self.cellHeight = [CGFloat]()
                    self.mCommentsTblView.setEmptyMessage("", tablename: self.mCommentsTblView)
                   self.mCommentsTblView.delegate = self
                  self.mCommentsTblView.dataSource = self

                    self.mCommentsTblView.reloadData()
                   // self.refreshContrainsts()
                    
                }}
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    
    // MARK: Create Comment
    func createComment(commentDict:Comment)
        
    {
//        SVProgressHUD.show(withStatus: "Please Wait")
        questionAPI.createComment(blogID: self.blogID!, commentDetials: commentDict){ (isSuccess,data, error) -> Void in
            SVProgressHUD.dismiss()
            //self.delegate?.didDissmiss(sender: self,folder: [Folder]())
            if (isSuccess){
                SVProgressHUD.dismiss()
               self.view.makeToast("Comment Created Successfully")
                //kAppDelegate.showNotification(text: "Comment Created Successfully")
                
                self.mCommentTxtFld.text = ""
                
                self.getAllComments()
                
                
            }else{
                SVProgressHUD.dismiss()
                if error != nil{
                    self.view.makeToast(error!)
//                    kAppDelegate.showNotification(text: error!)
                }else{
                     self.view.makeToast("Something went wrong!")
                    //kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
        
    }
    
    
    
    func getUserDetail(UserID:String){
        UserAPI().getUserDetails(userId: UserID, pageNo: 1) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let userlist = data[APIConstants.data.rawValue] as! NSDictionary
                    self.userMdlVar = User.init(dictionary: userlist)
                    
                     self.mBlogImg.sd_setImage(with: URL.init(string:(self.userMdlVar!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
                }
                
            else{
                print("Getting Error")
            }
        }
        
    }
    
    
    func EmptyMessage(message:String, viewController:UITableViewController) {
        let rect = CGRect(origin: CGPoint(x: 0,y :0), size: CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height))
        let messageLabel = UILabel(frame: rect)
        messageLabel.text = message
        messageLabel.textColor = UIColor.black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        viewController.tableView.backgroundView = messageLabel;
        viewController.tableView.separatorStyle = .none;
    }

    
    
    
    
}


extension CommentsVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.commentModlArry.count == 0 || self.commentModlArry.isEmpty == true || self.commentModlArry == nil {
            self.mCommentsTblView.setEmptyMessage("No Comments Yet", tablename: self.mCommentsTblView)
        }
        else {
            self.mCommentsTblView.restore()
        }
        
        return self.commentModlArry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTblCellID", for: indexPath) as! CommentsTblCell
        let comment = self.commentModlArry[indexPath.row]
   
        
        cell.mNameLbl.text = comment.user?.name
        cell.mTimeLbl.text = comment.createdAt?.utcStringToDayName
        cell.mCommentLbl.text = comment.text
        if comment.user!.imgUrl != nil {
            cell.mUserImg.sd_setImage(with: URL.init(string:(comment.user!.imgUrl!.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "blogdefaultimg")) }
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    

    }
