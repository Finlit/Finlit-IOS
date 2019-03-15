//
//  UserChatRoomVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 23/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SVProgressHUD
import Toast_Swift
class UserChatRoomVC: UIViewController {
    
    var questionApi : QuestionAPI!
    var chatID = String()
    var chatDictionary : Chat!
    var UserDictionary : User!
    var chatArry: [Chat]!
    var userApi : UserAPI!
    var UserDict : User?
    var ref: DatabaseReference!
    var opponentID = String()
    var opponentName = String()
    var opponentImgUrl = String()
    var chatobjectarray = NSMutableArray()
    private var ParticipantsDictionary : Participants!
    var mlabelHeight = Int()
    var chatBlockBool = Bool()
    var blockStr = String()
    @IBOutlet weak var mMsgtxtfld: UITextField!
    @IBOutlet weak var mUserChatRoomTblCell: UITableView!
    @IBOutlet weak var mTypeMessageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userApi = UserAPI.sharedInstance
        self.mUserChatRoomTblCell.delegate = self
        self.mUserChatRoomTblCell.dataSource = self
        self.navigationController?.navigationBar.isHidden = false
        navigationItem.title = opponentName
        mUserChatRoomTblCell.estimatedRowHeight = 90
        mUserChatRoomTblCell.rowHeight = UITableViewAutomaticDimension
        chatArry = [Chat]()
       chatBlockBool = true
        blockStr = "Block"
         chatModelData()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    @IBAction func mSendMsgBtnAct(_ sender: Any) {
     createchat()
    self.view.endEditing(true)
        
    }
    
    @IBAction func mMorebtnAct(_ sender: Any) {
        let alert=UIAlertController(title:"Finlit", message: "What would you like to do?", preferredStyle:UIAlertControllerStyle.alert )
        
        let blockButton = UIAlertAction(title: "Block", style: .default, handler: { (action) -> Void in
            print("Block button tapped")
            self.blockUser(userDict: ["userId":self.UserDict?.id! as AnyObject])
            })
        
        alert.addAction(blockButton)
            
        
//        alert.addAction(UIAlertAction(title: blockStr, style: UIAlertActionStyle.default, handler: {
//            _ in print("FOO")
//
//            if self.chatBlockBool == true{
//                self.blockchat()
//                self.chatBlockBool = false
//                self.blockStr = "Unblock"
//            }else{
//                self.unblockchat()
//                self.chatBlockBool = true
//                self.blockStr = "Block"
//            }
//        }))
        
        
       
        alert.addAction(UIAlertAction(title: "Report", style: UIAlertActionStyle.default, handler: {
            _ in print("FOO ")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.destructive, handler: {
            _ in print("FOO ")
        }))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    //MARK: Block User
    func blockUser(userDict:Dictionary<String, AnyObject>)
        
    {
        userApi.blockUser(userDetails: userDict as Dictionary<String, AnyObject> ){ (isSuccess,response, error) -> Void in
            SVProgressHUD.dismiss()
            
            if (isSuccess){
                SVProgressHUD.dismiss()
                self.view.makeToast("User Blocked Successfully")
                self.navigationController?.popViewController(animated: true)
                
            }
            else{
                SVProgressHUD.dismiss()
                if error != nil{
                    self.view.makeToast(error!)
                    
                }else{
                    self.view.makeToast("Something Went Wrong")
                    
                }
            }
            
        }
        
        
    }
    
    
    
    
    // MARK:- Chat Model Data
    func chatModelData(){
        self.questionApi = QuestionAPI.sharedInstance
        
        self.UserDictionary = User.init(dictionary: NSDictionary())
        self.UserDictionary.id = opponentID

        
        self.chatDictionary = Chat.init(dictionary: NSDictionary())
        self.chatDictionary.chatType = "normal"
  
        self.chatDictionary.lastMessage = "last message"

        var dict = ["chatType":"normal" as AnyObject,"lastMessage":"last" as AnyObject] as [String:Any]
        var participants = [[String:String]]()
        participants.append(["userId":opponentID])
        dict["participants"] = participants
        print(dict)
        chatidentity(Chats: dict)
        
    }
    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    // MARK:- Get Chat Id from API
    func chatidentity(Chats: [String:Any]){
        QuestionAPI().Chatadd(postDetials: Chats) { (isSuccess,response, error) in
            print(response!)
            if isSuccess == true{
                let chatdata = response![APIConstants.data.rawValue] as! NSDictionary
                print(chatdata)
                self.chatDictionary = Chat.init(dictionary: chatdata)
                self.chatID = self.chatDictionary.chatId!
               
                if self.chatDictionary.chatId != nil{
                    
                    Constants.kUserDefaults.set(self.chatID, forKey: appConstants.chatid)
                    self.chatDictionary = Chat.init(dictionary: NSDictionary())!
                    self.chatDictionary?.chatId = self.chatID
                 
                    self.setZeroUnreadCount(userDetails: self.chatDictionary)
                    self.getChat()

                }
                
                else{
                }
                
            }
            else{
                
                self.view.makeToast("An Error Occurred.Try Again")
                
            }
        }
    }
    
    
    // MARK:- Create Chat on Firebase
    func createchat(){
                       self.chatID = chatDictionary.chatId!
                        print(self.chatID)
                        self.chatID = Constants.kUserDefaults.value(forKey:appConstants.chatid) as! String
                        let myId = Constants.kUserDefaults.value(forKey: appConstants.userId)
                        self.ref = Database.database().reference()
                        let AutoID = self.ref.childByAutoId()
                        print(AutoID.key!)
        
        
                        let dict:Dictionary<String, Any>? = ["chatId": self.chatID,
                                                             "imgUrl": opponentImgUrl,
                                                             "message":self.mMsgtxtfld.text!,
                                                             "msgId":AutoID.key!,
                                                             "myId":myId!,
                                                             "opponentId":self.opponentID,
                                                             "timeStamp": ServerValue.timestamp()
                        ]
                        print(dict!)
                        let refs = self.ref.child("messages").child(self.chatID)
                        print(refs)
                        let ref2 = refs.child(AutoID.key!)
                        print(ref2)
                        ref2.setValue(dict)
        
        
                       self.chatDictionary = Chat.init(dictionary: NSDictionary())!
                       self.chatDictionary.lastMessage = self.mMsgtxtfld.text!

                       self.incUnreadCount(userDetails : chatDictionary!)
                       self.mMsgtxtfld.text = ""
                       self.getChat()
        
      
    }
    
    
    //MARK :GET CHAT FROM FIREBASE
    func getChat(){
        print(chatID)

       
        SVProgressHUD.show(withStatus: "Loading Chat")
  
        
        self.ref = Database.database().reference()
        self.ref.child("messages").child(chatID).queryOrdered(byChild: "timeStamp").observe(.value, with: { (data) in
            print(data)
            
            if data.value! is NSNull {
            SVProgressHUD.dismiss()
                
            }
            
            else{
                let values = data.value as? NSDictionary
                print(values!)
                self.chatobjectarray.removeAllObjects()
                for sort in data.children{
                    print(sort)
                    let snap = sort as! DataSnapshot
                    self.chatobjectarray.add(snap.value!)
                }

                self.chatArry.removeAll()
                
                self.chatArry = Chat.modelsFromDictionaryArray(array: self.chatobjectarray)
                SVProgressHUD.dismiss()
                self.mUserChatRoomTblCell.reloadData()
                self.scrollToBottom()
            }
            
            
        })
        { (error) in
            print(error.localizedDescription)
      
        }
    }
    
    func setZeroUnreadCount(userDetails : Chat){
        UserAPI().setCount(userDetials: userDetails) { (isSuccess, response, error) in
            print(isSuccess)
        }
    }
    func incUnreadCount(userDetails : Chat){
        UserAPI().incUnreadCount(userDetials: userDetails) { (isSuccess, response, error) in
            print(isSuccess)
        }
    }
    func blockchat(){
        QuestionAPI().blockChat(postID: chatID) { (isSuccess, error) in
            print(isSuccess)
        }
    }
    func unblockchat(){
        QuestionAPI().unblockChat(postID: chatID) { (isSuccess, error) in
            print(isSuccess)
        }
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.chatArry.count-1, section: 0)
            self.mUserChatRoomTblCell.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    func timestampToDate(Timestamp :Double,completion: (String) -> ()){
        let x = Timestamp / 1000
        let date = NSDate(timeIntervalSince1970: x)
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .medium
        
        let localDate = formatter.string(from: date as Date)
        completion(localDate)
        
    }
}

extension UserChatRoomVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mUserChatRoomTblCell.dequeueReusableCell(withIdentifier: "UserChatRoomTblCellID", for: indexPath) as! UserChatRoomTblCell
       
        mlabelHeight = cell.mLabel.calculateMaxLines()
       
        timestampToDate(Timestamp:chatArry[indexPath.row].timeStamp!) { (coverttime) in
            cell.mlabel1.text! = coverttime

        }
        
        
        if (Constants.kUserDefaults.value(forKey: appConstants.id)as! String) != chatArry[indexPath.row].opponentId{
            cell.mSenderImg.isHidden = false
            cell.mUserImage.isHidden = true
            if chatArry[indexPath.row].message != nil{
                cell.mLabel.text = chatArry[indexPath.row].message!
            }
            if  Constants.kUserDefaults.value(forKey: appConstants.UserImage) != nil{
                let Userimage = Constants.kUserDefaults.value(forKey: appConstants.UserImage)
                if Userimage != nil{
                    print(Userimage)
                    let urlimage = URL(string: Userimage! as! String)
                    print(urlimage)
                    cell.mSenderImg.af_setImage(withURL: urlimage!)
                    
                }else{
                    
                }
                
            }
            cell.mLabel.textAlignment = .right
            cell.mImageView.image = #imageLiteral(resourceName: "senderimg")
        }else{
            cell.mSenderImg.isHidden = true
            cell.mUserImage.isHidden = false
            cell.mLabel.text = chatArry[indexPath.row].message!
            if self.opponentImgUrl != ""{
                let urlimage = URL(string: opponentImgUrl)
                cell.mUserImage.af_setImage(withURL: urlimage!)
            }
            cell.mImageView.image = #imageLiteral(resourceName: "receiverimg")
            cell.mLabel.textAlignment = .left
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(mlabelHeight)
        if mlabelHeight == 1{
       return 86
        }else if mlabelHeight == 3{
            return 133
        }else{
            return UITableViewAutomaticDimension
         }
    }
}
extension UILabel {
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
    
}
