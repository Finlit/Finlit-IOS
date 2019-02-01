//
//  MatchesVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireImage
class MatchesVC: UIViewController{
  
    var VCcheckInt = Int()
    var userApi :UserAPI!
    var usersdata : [User]!
    var questionApi : QuestionAPI!
    var checkarrMenu = NSMutableArray()
    var opponentID = String()
    var Chatlistarr = NSMutableArray()
    var chatArr : [Chat]!
    @IBOutlet weak var mMyCircleTblCell: UITableView!
    @IBOutlet weak var mSearchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.mMyCircleTblCell.delegate = self
//        self.mMyCircleTblCell.dataSource = self
         self.navigationController?.navigationBar.isHidden = false
        self.mSearchTextField.delegate = self
        self.userApi = UserAPI.sharedInstance
        self.questionApi = QuestionAPI.sharedInstance
        self.usersdata = [User]()
        self.chatArr = [Chat]()
        mMyCircleTblCell.estimatedRowHeight = 165
        mMyCircleTblCell.rowHeight = UITableViewAutomaticDimension
        if VCcheckInt == 0{
            //navigationItem.title = "Find Matches"
            navigationItem.title = "DATES"
            if Constants.kUserDefaults.value(forKey:appConstants.selecttype) != nil{
                let type =  Constants.kUserDefaults.value(forKey:appConstants.selecttype)as! String
                getallusers(type: "?gender=\(type)")
            }else{
                getallusers(type: "")
            }
          
        }else{
            //navigationItem.title = "My Matches"
            navigationItem.title = "PENDING DATES"
             GetChatlist()
        }
       
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    //MARK:- Api
    func getallusers(type:String) {
        SVProgressHUD.show(withStatus: "Processing...")
        userApi.getAllUsers(type:type) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    //                    self.hideProgress()
                    self.usersdata.removeAll()
                    let userList = data[APIConstants.items.rawValue] as! NSArray
                  
                    self.usersdata = User.modelsFromDictionaryArray(array: userList)
                    //
                    self.mMyCircleTblCell.reloadData()
                    SVProgressHUD.dismiss()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
        }
    }
    //MARK:- Fav n UnFav
    func favPost(PostId:String){
        questionApi.favPost(postID: PostId) { (data, error) in
            print(data)
            if data == true{
                
            }else{
                 print(error!)
            }

        }
    }
    func UnfavPost(PostId:String){
        questionApi.UnfavPost(postID: PostId) { (data, error) in
            print(data)
            if data == true{
                
            }else{
                print(error!)
            }
        }
    }
    
    //MARK:- SearchUser
    func AllSearch(Name:String){
        userApi.AllSearch(query: Name) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    self.usersdata.removeAll()
                    let userList = data[APIConstants.items.rawValue] as! NSArray
                    
                    self.usersdata = User.modelsFromDictionaryArray(array: userList)
                    
                    self.mMyCircleTblCell.reloadData()
                    SVProgressHUD.dismiss()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
        }
    }
    
    // MARK:- Chat List
    func GetChatlist() {
       SVProgressHUD.show()
        QuestionAPI().getchatlist() { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let postList = data[APIConstants.items.rawValue] as! NSArray
                    for i in 0..<postList.count{
                    let chatID = (postList.object(at: i)as! NSDictionary).value(forKey: "id")as! String
                    print(chatID)
                    let participants = (postList.object(at: i)as! NSDictionary).value(forKey: "participants")as! NSArray
                    print(participants)
                    for dict in participants{
                        print(dict)
                        let id = ((dict as! NSDictionary).value(forKey: "user")as! NSDictionary).value(forKey: "id")as! String
                        print(id)
                        
                        if id != Constants.kUserDefaults.value(forKey: appConstants.id)as? String{
                            self.Chatlistarr.add(dict)

                        
                        }else{
                            print("Differnt dict")
                        }
                        
                    }

                    }
                    print(self.Chatlistarr)
                    self.chatArr.removeAll()
                    self.chatArr = Chat.modelsFromDictionaryArray(array: self.Chatlistarr)
                    self.mMyCircleTblCell.reloadData()
                    SVProgressHUD.dismiss()
                    }else{
                    print("Getting Error")
                    SVProgressHUD.dismiss()
                }
            
            
            }
            
        }
    }
}

extension MatchesVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if VCcheckInt == 0{
        return usersdata.count
        }else{
            return chatArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mMyCircleTblCell.dequeueReusableCell(withIdentifier: "MyCircleTblCellID", for: indexPath) as! MyCircleTblCell
        cell.mView.dropShadow(scale: true)
        
        cell.mMessageBtn.addTarget(self, action: #selector(mMessageBtnAct(sender:)), for: .touchUpInside)
        cell.mMessageBtn.tag = indexPath.row
        cell.mViewProfileBtn.addTarget(self, action: #selector(mViewProfile(sender:)), for: .touchUpInside)
        cell.mViewProfileBtn.tag = indexPath.row
        if VCcheckInt == 0{
        cell.mNameLbl.text = self.usersdata[indexPath.row].name
        cell.mLabel1.text = self.usersdata[indexPath.row].address
        cell.mLabel.text = self.usersdata[indexPath.row].question
        
        let url = self.usersdata[indexPath.row].imgUrl
        if url != nil{
            let urlimage = URL(string: url!)
            cell.mImageView.af_setImage(withURL: urlimage!)
        }else{
             cell.mImageView.image = #imageLiteral(resourceName: "default_user_square")
             }
        if self.usersdata[indexPath.row].isFavourite == 1{
            cell.mImageView1.image = #imageLiteral(resourceName: "image-8")
        }else{
            cell.mImageView1.image = #imageLiteral(resourceName: "icon_heart_unfilled")
             }
        }else{
            cell.mNameLbl.text = self.chatArr[indexPath.row].name
            cell.mLabel1.text = self.chatArr[indexPath.row].address
           // cell.mLabel.text = self.chatArr[indexPath.row].question
            
            let url = self.chatArr[indexPath.row].imgUrl
            if url != nil{
                let urlimage = URL(string: url!)
                cell.mImageView.af_setImage(withURL: urlimage!)
            }else{
                cell.mImageView.image = #imageLiteral(resourceName: "default_user_square")
            }
            if self.chatArr[indexPath.row].isFavourite == 1{
                cell.mImageView1.image = #imageLiteral(resourceName: "image-8")
            }else{
                cell.mImageView1.image = #imageLiteral(resourceName: "icon_heart_unfilled")
            }
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = mMyCircleTblCell.cellForRow(at: indexPath)as! MyCircleTblCell
        cell.mImageView1.image = #imageLiteral(resourceName: "image-8")
        print(indexPath.row)
        if VCcheckInt == 0{
        let otherUserId = self.usersdata[indexPath.row].id
        print(otherUserId!)
        favPost(PostId: otherUserId!)
        }else{
            let otherUserId = self.chatArr[indexPath.row].id
            print(otherUserId!)
            favPost(PostId: otherUserId!)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = mMyCircleTblCell.cellForRow(at: indexPath)as! MyCircleTblCell
        cell.mImageView1.image = #imageLiteral(resourceName: "icon_heart_unfilled")
        print(indexPath.row)
         if VCcheckInt == 0{
        let otherUserId = self.usersdata[indexPath.row].id
        print(otherUserId!)
        UnfavPost(PostId: otherUserId!)
         }else{
            let otherUserId = self.chatArr[indexPath.row].id
            print(otherUserId!)
            UnfavPost(PostId: otherUserId!)
        }
    }
    @objc func mMessageBtnAct(sender: UIButton){
        let btnclick : Int = sender.tag
        
        if VCcheckInt == 0{
        let otherUserId = self.usersdata[btnclick].id
        let otherUsername = self.usersdata[btnclick].name
        print(otherUserId!)
        let vc  = storyboard?.instantiateViewController(withIdentifier: "UserTakeQuizVCID")as! UserTakeQuizVC
        vc.opponentID = otherUserId!
        vc.opponentName = otherUsername!
        if self.usersdata[btnclick].imgUrl != nil{
        let otherImgUrl = self.usersdata[btnclick].imgUrl
        vc.opponentImgUrl = otherImgUrl!
        }
        navigationController?.pushViewController(vc, animated: true)
        }else{
            let otherUserId = self.chatArr[btnclick].id
            let otherUsername = self.chatArr[btnclick].name
            print(otherUserId!)
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserTakeQuizVCID")as! UserTakeQuizVC
            vc.opponentID = otherUserId!
            vc.opponentName = otherUsername!
            if self.chatArr[btnclick].imgUrl != nil{
                let otherImgUrl = self.chatArr[btnclick].imgUrl
                vc.opponentImgUrl = otherImgUrl!
            }
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    @objc func mViewProfile(sender: UIButton){
        let btnclick : Int = sender.tag
         if VCcheckInt == 0{
        let otherUserId = self.usersdata[btnclick].id
        let vc  = storyboard?.instantiateViewController(withIdentifier: "UserProfileVCID")as! UserProfileVC
        vc.opponentId = otherUserId!
        vc.VCcheckInt = 1
        navigationController?.pushViewController(vc, animated: true)
         }else{
            let otherUserId = self.chatArr[btnclick].id
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserProfileVCID")as! UserProfileVC
            vc.opponentId = otherUserId!
            vc.VCcheckInt = 1
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
extension MatchesVC : UITextFieldDelegate{

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("TextField should end editing method called")
        if mSearchTextField.text != ""{
            AllSearch(Name: mSearchTextField.text!)
        }else{
            if Constants.kUserDefaults.value(forKey:appConstants.selecttype) != nil{
                let type =  Constants.kUserDefaults.value(forKey:appConstants.selecttype)as! String
                getallusers(type: "?gender=\(type)")
            }else{
                getallusers(type: "")
            }
        }
        
        return true;
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if mSearchTextField.text != ""{
            AllSearch(Name: mSearchTextField.text!)
        }else{
            if Constants.kUserDefaults.value(forKey:appConstants.selecttype) != nil{
                let type =  Constants.kUserDefaults.value(forKey:appConstants.selecttype)as! String
                getallusers(type: "?gender=\(type)")
            }else{
                getallusers(type: "")
            }
        }
        return true
    }
}
