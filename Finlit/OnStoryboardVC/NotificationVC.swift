//
//  NotificationVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 15/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController {

    @IBOutlet weak var mNotificationsTblView: UITableView!

    var notificationMdlArry : [Notification]!
    var datesAPI : DatesAPI!
    
    override func viewDidLoad() {
        self.notificationMdlArry = [Notification]()
        self.datesAPI = DatesAPI.sharedInstance
       
         self.navigationController?.navigationBar.isHidden = false
         self.getAllNotifications()
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mNotificationsTblView.delegate = self
        self.mNotificationsTblView.dataSource = self
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   
    }

    @IBAction func mBackBtn(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: GET NOTIFICATIONS
    func getAllNotifications() {
        datesAPI.getAllNotifications() { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                let postList = data[APIConstants.items.rawValue] as! NSArray
                self.notificationMdlArry = Notification.modelsFromDictionaryArray(array: postList)
                self.mNotificationsTblView.reloadData()
            }
            else{
                print("Getting Error")
                
            }
            
        }
        

    }
    
}

extension NotificationVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.notificationMdlArry.count == 0 || self.notificationMdlArry.isEmpty == true || self.notificationMdlArry == nil {
            self.mNotificationsTblView.setEmptyMessage("No Notifications Yet", tablename: self.mNotificationsTblView)
        }
        else {
            self.mNotificationsTblView.restore()
        }
        
        return self.notificationMdlArry.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTblCellID", for: indexPath) as! NotificationTblCell
        cell.selectionStyle = .none
        let notification = self.notificationMdlArry[indexPath.row]
        cell.mDescriptionLbl.text = notification.description
        cell.mTimeLbl.text = notification.createdAt?.utcStringToLocalDateTimeForNotification
        if notification.imgUrl != nil {
            cell.mImageView.sd_setImage(with: URL.init(string:((notification.imgUrl!.httpsExtend))), placeholderImage: #imageLiteral(resourceName: "default_user_square"))
        
        }
         return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
}

