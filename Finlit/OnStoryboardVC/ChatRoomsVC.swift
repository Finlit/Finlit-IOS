//
//  ChatRoomsVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 21/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class ChatRoomsVC: UIViewController {
     var NameArry = ["Room 156", "Room 157"]
    var LabelArry = ["2 hour ago","3 hours ago"]

   
    @IBOutlet weak var mChatRoomsTblCell: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mChatRoomsTblCell.delegate = self
        self.mChatRoomsTblCell.dataSource = self
        self.navigationController?.navigationBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func mBackbtn(_ sender: UIBarButtonItem)
        {
     self.navigationController?.popViewController(animated: true)
    }
    

}

extension ChatRoomsVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.NameArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRoomTblCellID", for: indexPath) as! ChatRoomTblCell
        
        cell.mNameLbl.text = self.NameArry[indexPath.row]
        cell.mLabel.text = self.LabelArry[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
        
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0
//        {
//        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "UserTakeQuizVCID") as! UserTakeQuizVC
//        self.navigationController?.pushViewController(destinationvc, animated: true)
//            return
//        }
//      
//        self.navigationController?.popViewController(animated: true)
//        
//    }
    
    
    
    
}
