//
//  BlockedUsersVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 01/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit
import Toast_Swift

class BlockedUsersVC: UIViewController {

    @IBOutlet weak var mBlockedUsersTblView: UITableView!
    
    var userMdlArry : [User]!
    var userApi : UserAPI!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userMdlArry = [User]()
        self.userApi = UserAPI.sharedInstance
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getAllBlockedUsers()
        
    }
    
    

    @IBAction func mBackBtnTapped(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: Get All Users
    func getAllBlockedUsers() {
        
        UserAPI().getAllBlockedUsers(query: "",pageNo: 0) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let userList = data[APIConstants.items.rawValue] as! NSArray
    
                    
                    self.userMdlArry = User.modelsFromDictionaryArray(array: userList)
                    self.mBlockedUsersTblView.delegate = self
                    self.mBlockedUsersTblView.dataSource = self
                    self.mBlockedUsersTblView.reloadData()
                    
                    
                    
                }}
            else{
                print("Getting Error")
                
            }
            
        }
    }
    
    
    // MARK: UnBlock User Function
    
    func UnBlockUser(userDict:Dictionary<String, AnyObject>)
        
    {
        SVProgressHUD.show(withStatus: "Please Wait")
        userApi.unBlockUser(userDetails: userDict as Dictionary<String, AnyObject> ){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                self.view.makeToast("User Unblocked Successfully")
                self.getAllBlockedUsers()
                
            }
            else{
                SVProgressHUD.dismiss()
                if error != nil{
                    kAppDelegate.showNotification(text: error!)
                }else{
                    kAppDelegate.showNotification(text: "Something went wrong!")
                }
            }
            
        }
    }
    
}
    
    
    
    
    


extension BlockedUsersVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.userMdlArry.count == 0 || self.userMdlArry.isEmpty == true || self.userMdlArry == nil {
            self.mBlockedUsersTblView.setEmptyMessage("No Users Yet", tablename: self.mBlockedUsersTblView)
        }
        else {
            self.mBlockedUsersTblView.restoreWithNoSeparator()
        }
        
        return self.userMdlArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockedUsersTblCellID", for: indexPath) as! BlockedUsersTblCell
        let userr = userMdlArry[indexPath.row]
        cell.mNameLbl.text = userr.name
        cell.mIntrestLbl.text = userr.interest![0].answer
        cell.mUnblockBtn.tag = indexPath.row
        cell.mUnblockBtn.addTarget(self, action: #selector(unBlockBtnTapped), for: .touchUpInside)
        
        if userr.imgUrl != nil {
            cell.mUserImg.sd_setImage(with: URL.init(string:((userr.imgUrl!.httpsExtend))), placeholderImage: #imageLiteral(resourceName: "portrait2"))
       
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 82
    }
    
    
    
    @objc func unBlockBtnTapped(sender:UIButton) {
        let tag = sender.tag
        let userr = userMdlArry[tag]
        if userr.id != nil{
         let userDict = ["userId":userr.id]
            self.UnBlockUser(userDict: userDict as Dictionary<String, AnyObject>)}
        
    }
    
    
}
