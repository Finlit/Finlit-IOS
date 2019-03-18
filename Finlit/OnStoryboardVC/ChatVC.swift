//
//  ChatVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ChatVC: UIViewController,UITextFieldDelegate {
    
    var Chatlistarr = NSMutableArray()
    var chatArr : [Chat]!

    @IBOutlet weak var mSearchHereTextField: UITextField!
    
    @IBOutlet weak var mChatTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mChatTblView.delegate = self
        self.mChatTblView.dataSource = self
         self.navigationController?.navigationBar.isHidden = false
        self.mSearchHereTextField.delegate = self
        self.chatArr = [Chat]()
        GetChatlist()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
     
    }

//TEXT FIELD DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
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
         //cell.mView.dropShadow(scale: true)
        cell.mNameLbl.text = self.chatArr[indexPath.row].name
        cell.mLabel1.text = String(describing:self.chatArr[indexPath.row].unreadCount!)
        cell.mLabel.text = self.chatArr[indexPath.row].lastMessage
        
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
extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1.5)
        layer.shadowRadius = 3
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
