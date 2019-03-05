//
//  MyFavouritesVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class MyFavouritesVC: UIViewController {
    
    var NameArry = ["John Smith"]
    var NameArry1 = ["Real state"]
    var NameArry2 = ["36 Evenue Alkaska Usa"]
    var ImageArry = ["image-6"]
    var ImageArry1 = ["image-8"]
    var ImageArry2 = ["moenybag"]
    var ImageArry3 = ["pinpoint"]
    var ImageArry4 = ["clockicon"]
    var MessageArry = ["Message"]
    var ViewProfileArry = ["View Profile"]
    var userApi :UserAPI!
    var usersdata : [User]!
    var questionApi : QuestionAPI!
    @IBOutlet weak var mMyFavouriteTblCell: UITableView!
    @IBOutlet weak var mSearchHereTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mMyFavouriteTblCell.delegate = self 
        self.mMyFavouriteTblCell.dataSource = self
        self.questionApi = QuestionAPI.sharedInstance
        self.navigationController?.navigationBar.isHidden = false
        
        self.mSearchHereTextField.delegate = self
        self.userApi = UserAPI.sharedInstance
        self.usersdata = [User]()
        getAllFavlist()
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
    func getAllFavlist() {
        SVProgressHUD.show(withStatus: "Processing...")
        userApi.getAllFavUsers() { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    self.usersdata.removeAll()
                    let userList = data[APIConstants.items.rawValue] as! NSArray
                    
                    self.usersdata = User.modelsFromDictionaryArray(array: userList)
                    //
                    self.mMyFavouriteTblCell.reloadData()
                    SVProgressHUD.dismiss()
                }}
            else{
                SVProgressHUD.dismiss()
                print("Getting Error")
            }
        }
    }
    //MARK:- FavSearchApi
    func favSearch(Name:String){
        userApi.favSearch(query: Name) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    self.usersdata.removeAll()
                    let userList = data[APIConstants.items.rawValue] as! NSArray
                    
                    self.usersdata = User.modelsFromDictionaryArray(array: userList)
                    
                    self.mMyFavouriteTblCell.reloadData()
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
    
}

extension MyFavouritesVC: UITableViewDelegate, UITableViewDataSource
{
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return usersdata.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = mMyFavouriteTblCell.dequeueReusableCell(withIdentifier: "MyFavouriteTblCellID", for: indexPath) as! MyFavouriteTblCell
    cell.mView.dropShadow(scale: true)
    cell.mMessageBtn.addTarget(self, action: #selector(mMessageBtnAct(sender:)), for: .touchUpInside)
    cell.mMessageBtn.tag = indexPath.row
    cell.mViewProfileBtn.addTarget(self, action: #selector(mViewProfile(sender:)), for: .touchUpInside)
    cell.mViewProfileBtn.tag = indexPath.row
    cell.mNameLbl.text = self.usersdata[indexPath.row].name
    cell.mLabel1.text = self.usersdata[indexPath.row].address
    cell.mLabel.text = self.usersdata[indexPath.row].question
    
    let url = self.usersdata[indexPath.row].imgUrl
    if url != nil{
        let urlimage = URL(string: url!)
        cell.mImageView.sd_setImage(with: urlimage, placeholderImage: #imageLiteral(resourceName: "default_user_square"))
    }else{
    }
    if self.usersdata[indexPath.row].isFavourite == 1{
        cell.mImageView1.image = #imageLiteral(resourceName: "image-8")
    }else{
        cell.mImageView1.image = #imageLiteral(resourceName: "icon_heart_unfilled")
    }
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = mMyFavouriteTblCell.cellForRow(at: indexPath)as! MyMatchesTblCell
        cell.mImageView1.image = #imageLiteral(resourceName: "image-8")
        print(indexPath.row)
            let otherUserId = self.usersdata[indexPath.row].id
            print(otherUserId!)
            favPost(PostId: otherUserId!)
      
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = mMyFavouriteTblCell.cellForRow(at: indexPath)as! MyMatchesTblCell
        cell.mImageView1.image = #imageLiteral(resourceName: "icon_heart_unfilled")
        print(indexPath.row)
        
            let otherUserId = self.usersdata[indexPath.row].id
            print(otherUserId!)
            UnfavPost(PostId: otherUserId!)
      
    }
    @objc func mMessageBtnAct(sender: UIButton){
        let btnclick : Int = sender.tag
        
        
            let otherUserId = self.usersdata[btnclick].id
            let otherUsername = self.usersdata[btnclick].name
            print(otherUserId!)
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserChatRoomVCID")as! UserChatRoomVC
            vc.opponentID = otherUserId!
            vc.opponentName = otherUsername!
            if self.usersdata[btnclick].imgUrl != nil{
                let otherImgUrl = self.usersdata[btnclick].imgUrl
                vc.opponentImgUrl = otherImgUrl!
            }
            navigationController?.pushViewController(vc, animated: true)
      
    }
    @objc func mViewProfile(sender: UIButton){
        let btnclick : Int = sender.tag
       
            let otherUserId = self.usersdata[btnclick].id
            let vc  = storyboard?.instantiateViewController(withIdentifier: "UserProfileVCID")as! UserProfileVC
            vc.opponentId = otherUserId!
            vc.VCcheckInt = 1
            navigationController?.pushViewController(vc, animated: true)
       
    }
}
extension MyFavouritesVC : UITextFieldDelegate{
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if mSearchHereTextField.text != nil{
            favSearch(Name: mSearchHereTextField.text!)
        }else{
            getAllFavlist()
        }
        
        return true;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if mSearchHereTextField.text != nil{
             favSearch(Name: mSearchHereTextField.text!)
        }else{
             getAllFavlist()
        }
        return true
    }
}
