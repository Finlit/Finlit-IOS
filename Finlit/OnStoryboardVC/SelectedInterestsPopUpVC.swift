//
//  SelectedInterestsPopUpVC.swift
//  Finlit
//
//  Created by Gurpreet Gulati on 25/03/19.
//  Copyright © 2019 Gurpreet Singh. All rights reserved.
//

import UIKit

class SelectedInterestsPopUpVC: UIViewController {

    @IBOutlet weak var mInterestTblView: UITableView!
    
        var QuestionArr = ["What common interests would you like to share with other members?","Who are you looking for?","What is your eye color?","What is your hair color?","What is your faith?","What’s your level of education?","How often do you exercise?","Do you smoke?","How often do you drink?","Do you have any kids?","Do you want children?","What’s your current annual income?","What are you saving for?","What kind of exercise do you enjoy?"]
    
     var checkarrMenu = NSMutableArray()
     var indexInt = Int()
    var InteresrMdlArry : [InterestModel]?
    var indexPathsOfSelectedQuestions = [IndexPath]()
    var answersDictionary = [IndexPath:String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.InteresrMdlArry != nil {
            for i in InteresrMdlArry! {
                if self.QuestionArr.contains(i.question!) {
                    let indexOfContainingQues = QuestionArr.firstIndex(of: i.question!)
                    let indexPathOfContainingQuestion = IndexPath(row: indexOfContainingQues!, section: 0)
                    self.indexPathsOfSelectedQuestions.append(indexPathOfContainingQuestion)
                    self.answersDictionary[indexPathOfContainingQuestion] = i.answer
                    
                    print("The index of the containing question is \(String(describing: indexOfContainingQues))")
                }
                
            }
        }
        
        
        self.mInterestTblView.delegate = self
        self.mInterestTblView.dataSource = self
        
    }
    



    @IBAction func mDoneBtnTapped(_ sender: UIButton) {
      self.dismiss(animated: true, completion: nil)
    }
    
    
   
}

extension SelectedInterestsPopUpVC : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.QuestionArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedInterestsTblCellID", for: indexPath) as! EditProfileTableViewCell
        cell.mtxtfld?.delegate = self
        cell.mtxtfld?.tag = indexPath.row
        cell.mCheckbtn.tag = indexPath.row
        
        cell.mtxtfld.setLeftPaddingPoints(10)
        cell.mlbl2.text = QuestionArr[indexPath.row]
       // cell.mCheckbtn.addTarget(self, action: #selector(checkbtn(sender:)), for: .touchUpInside)
      
        if self.indexPathsOfSelectedQuestions.contains(indexPath){
            cell.mImg2.image = #imageLiteral(resourceName: "pinkTick")
            cell.mtxtfld.isHidden = false
            cell.mlbl2.frame.size.height = 32
            cell.mBottomConstant.constant = 16
            cell.mtxtfld.isUserInteractionEnabled = false
           
            if self.answersDictionary.keys.contains(indexPath){
                cell.mtxtfld.text = self.answersDictionary[indexPath]
            }
      
        
        }else{
            cell.mImg2.image = nil
            cell.mtxtfld.isHidden = true
            cell.mlbl2.frame.size.height = 0
            cell.mBottomConstant.constant = -16
        }
        return cell
    }
    
    
//    @objc func checkbtn(sender: UIButton){
//
//        let touchPoint: CGPoint = sender.convert(CGPoint.zero, to: mInterestTblView)
//        // maintable --> replace your tableview name
//        let clickedButtonIndexPath = mInterestTblView.indexPathForRow(at: touchPoint)
//        if checkarrMenu.contains([clickedButtonIndexPath]){
//            checkarrMenu.remove([clickedButtonIndexPath])
//
//
//        }
//
//        else{
//            checkarrMenu.add([clickedButtonIndexPath])
//            self.indexInt = (clickedButtonIndexPath?.row)!
//        }
//
//
//        let indexPosition = IndexPath(row: (clickedButtonIndexPath?.row)!, section: 0)
//        mInterestTblView.reloadRows(at: [indexPosition], with: .none)
//    }

    
    
    
}


extension SelectedInterestsPopUpVC : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.view.endEditing(true)
        return false
    }

}
