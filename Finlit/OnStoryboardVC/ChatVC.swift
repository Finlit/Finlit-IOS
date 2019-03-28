//
//  ChatVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {
    
    var Chatlistarr = NSMutableArray()
    var ChatlistarrForMyUnreadCount = NSMutableArray()
    var chatArr : [Chat]!
    var chatMdlArryForLastMsg : [Chat]!
     var chatMdlArryForUnreadCount : [Chat]!
    
    

    @IBOutlet weak var mSearchHereTextField: UITextField!
    
    @IBOutlet weak var mChatTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mChatTblView.delegate = self
        self.mChatTblView.dataSource = self
         self.navigationController?.navigationBar.isHidden = false
        self.mSearchHereTextField.delegate = self
        self.chatArr = [Chat]()
        self.chatMdlArryForLastMsg = [Chat]()
        GetChatlist()
        let myId = Constants.kUserDefaults.value(forKey: appConstants.id) as! String
        print("My Id is \(myId)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
    }



    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)

    }
    // MARK:- Chat List
    func GetChatlist() {
        SVProgressHUD.show()
        QuestionAPI().getchatlist() { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let postList = data[APIConstants.items.rawValue] as! NSArray
                    
                    //WorkAround For Last Message
                    self.chatMdlArryForLastMsg = Chat.modelsFromDictionaryArray(array: postList)
                    
                    
                    for i in 0..<postList.count{
                        let chatID = (postList.object(at: i)as! NSDictionary).value(forKey: "id")as! String
                        print(chatID)
                        let participants = (postList.object(at: i)as! NSDictionary).value(forKey: "participants")as! NSArray
                        print("Printing below the participants array of dictionaries \(participants)")
                        for dict in participants{
                            print(dict)
                            let id = ((dict as! NSDictionary).value(forKey: "user")as! NSDictionary).value(forKey: "id")as! String
                            print(id)
                            
                            if id != Constants.kUserDefaults.value(forKey: appConstants.id)as? String{
                                self.Chatlistarr.add(dict)
                                
                            }
                            else if id == Constants.kUserDefaults.value(forKey: appConstants.id)as? String {
                                 self.ChatlistarrForMyUnreadCount.add(dict)
                                self.chatMdlArryForUnreadCount = Chat.modelsFromDictionaryArray(array: self.ChatlistarrForMyUnreadCount)
                                print("chatMdlArryForUnreadCount:\(self.chatMdlArryForUnreadCount)")
                            }
                            
                        }
                        
                    }
                    print(self.Chatlistarr)
                    self.chatArr.removeAll()
                    self.chatArr = Chat.modelsFromDictionaryArray(array: self.Chatlistarr)
                    self.mChatTblView.reloadData()
                    SVProgressHUD.dismiss()
                }else{
                    print("Getting Error")
                    SVProgressHUD.dismiss()
                }
                
                
            }
            
        }
    }
}



extension ChatVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTblCellID", for: indexPath) as! ChatTblCell
        cell.mNameLbl.text = self.chatArr[indexPath.row].name
        //cell.mLabel1.text = String(describing:self.chatArr[indexPath.row].unreadCount!)
        if self.chatArr.count == self.chatMdlArryForUnreadCount.count {
            cell.mLabel1.text = String(describing:self.chatMdlArryForUnreadCount[indexPath.row].unreadCount!)
            if self.chatMdlArryForUnreadCount[indexPath.row].unreadCount == 0{
                cell.mLabel1.isHidden = true
            }
        }
        
     
        //cell.mLabel.text = self.chatArr[indexPath.row].lastMessage
        if self.chatArr.count == self.chatMdlArryForLastMsg.count {
            cell.mLabel.text = self.chatMdlArryForLastMsg[indexPath.row].lastMessage
        }
        
        let url = self.chatArr[indexPath.row].imgUrl
        
        if url != nil{
            let urlimage = URL(string: url!)
            cell.mImageView.af_setImage(withURL: urlimage!)
        } else{
            cell.mImageView.image = #imageLiteral(resourceName: "default_user_square")
        }
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let otherUserId = self.chatArr[indexPath.row].id
        let otherUsername = self.chatArr[indexPath.row].name
        
        print(otherUserId!)
        let vc  = storyboard?.instantiateViewController(withIdentifier: "UserChatRoomVCID")as! UserChatRoomVC
        vc.opponentID = otherUserId!
        vc.opponentName = otherUsername!
        if self.chatArr[indexPath.row].imgUrl != nil{
            let otherImgUrl = self.chatArr[indexPath.row].imgUrl
            vc.opponentImgUrl = otherImgUrl!
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
}



extension ChatVC : UITextFieldDelegate {
    
    //TEXT FIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
     
    }
}

