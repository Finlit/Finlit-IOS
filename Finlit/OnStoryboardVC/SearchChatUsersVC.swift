//
//  SearchChatUsersVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 29/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class SearchChatUsersVC: UIViewController {

    @IBOutlet weak var mSearchTxtFld: UITextField!
    @IBOutlet weak var mUsersTblView: UITableView!
    var userMdlArry : [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
     mSearchTxtFld.delegate = self
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mUsersTblView.delegate = self
        self.mUsersTblView.dataSource = self
        self.navigationController?.navigationBar.isHidden = true
        mSearchTxtFld.becomeFirstResponder()
    }
    
    
    @IBAction func mCancelBtnTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
  
    //MARK : GET USERS API
    func getAllUsersWithSearch(type: String) {
        
        UserAPI().getAllUsersWithSearch(type: type){ (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let userlist = data[APIConstants.items.rawValue] as! NSArray
                
                    
                    self.userMdlArry = User.modelsFromDictionaryArray(array: userlist)
                    self.mUsersTblView.reloadData()
                    
                }
            }
                
            else{
                
                print("Getting Error")
            }
            
        }
    }
    

}

extension SearchChatUsersVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userMdlArry?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTblCellID", for: indexPath) as! ChatTblCell
        let userrr = self.userMdlArry![indexPath.row]
        cell.mView.layer.shadowColor = UIColor.clear.cgColor
   
        if let usersName = userrr.name {cell.mNameLbl.text = usersName}
        if let userImgUrl = userrr.imgUrl {   cell.mImageView.sd_setImage(with: URL.init(string:(userImgUrl.httpsExtend)), placeholderImage: #imageLiteral(resourceName: "default_user_square")) }
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let otherUserId = self.userMdlArry![indexPath.row].id else {return}
        guard let otherUsername = self.userMdlArry![indexPath.row].name else {return}
        
        let vc  = storyboard?.instantiateViewController(withIdentifier: "UserChatRoomVCID")as! UserChatRoomVC
        vc.opponentID = otherUserId
        vc.opponentName = otherUsername
        vc.isComingFromSearchChatScreen = true
        if self.userMdlArry![indexPath.row].imgUrl != nil{
            let otherImgUrl = self.userMdlArry![indexPath.row].imgUrl
            vc.opponentImgUrl = otherImgUrl!
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}


extension SearchChatUsersVC : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let subString = (textField.text! as NSString).replacingCharacters(in: range, with: string) // 2
   
        
        
        if subString.count != 0 { // 3 when a user clears the textField
            
            
            let nameTyped = subString
            self.getAllUsersWithSearch(type: nameTyped)
            print(nameTyped)
        }
        
        else {
            self.getAllUsersWithSearch(type: "")
        }
        return true
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
}
