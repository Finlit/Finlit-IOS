//
//  QuickQuizVC.swift
//  Finlit
//
//  Created by Gurpreet Singh on 09/10/18.
//  Copyright © 2018 Gurpreet Singh. All rights reserved.
//

import UIKit

class QuickQuizVC: UIViewController {
    
    
    @IBOutlet weak var mQuestionLbl: UILabel!
    var NameArry = ["Rise", "Fall", "Stay the same", "No relationship", "Don't know"]
    var ImageArry  =  ["tick", "tick", "tick", "tick", "tick"]
    var isCorrectIntArr = [Int]()
    @IBOutlet weak var mNext: UIButton!
    @IBOutlet weak var mQuickTblView: UITableView!
    
    
    var VCcheck = Int()
    var questionArry: [Questions]!
    var optionsArry : [Options]!
    var indexPosition = 0
    var IncrementInt = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mQuickTblView.delegate = self
        self.mQuickTblView.dataSource = self
        self.mNext.layer.cornerRadius = CGFloat(10)
        self.mNext.clipsToBounds = true
        self.questionArry = [Questions]()
        self.optionsArry = [Options]()
        IncrementInt = 0
        if VCcheck == 1{
            self.getAllQuestions(Name: "6")
        }else{
            self.getAllQuestions(Name: "10")
        }
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func mNextBtn(_ sender: UIButton) {
        print(questionArry[indexPosition].QuestionCount!)
        
        if IncrementInt < questionArry[indexPosition].QuestionCount! - 1{
            IncrementInt += 1
            print(IncrementInt)
            
            optionApiData(Index: IncrementInt)
        }else{
            Constants.kUserDefaults.set(questionArry[indexPosition].QuestionCount!, forKey: appConstants.totalQuestionCount)
        let destinationvc = self.storyboard?.instantiateViewController(withIdentifier: "CongratsVCID") as! CongratsVC
        self.navigationController?.pushViewController(destinationvc, animated: true)
        }
    }
    
    @IBAction func mBackBtn(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    //MARK: Get All Questions
    func getAllQuestions(Name: String = "") {
        SVProgressHUD.show()
        QuestionAPI().getAllQuestions(name: Name,pageNo: 0) { (data, error) in
            if data[APIConstants.isSuccess.rawValue] as! Bool == true {
                if error == nil{
                    let postList = data[APIConstants.items.rawValue] as! NSArray
                     self.questionArry = Questions.modelsFromDictionaryArray(array: postList)
                    SVProgressHUD.dismiss()
                    
                    self.optionApiData(Index: 0)
                
                    
                }}
            else{
                print("Getting Error")
                 SVProgressHUD.dismiss()
            }
            
        }
    }
    
    func optionApiData(Index:Int){
        self.optionsArry.removeAll()
        let firstques = self.questionArry[self.indexPosition].QuestionArr
        print(firstques!)
        _ = (firstques?.object(at: Index) as! NSDictionary).value(forKey: "id")as! String
        let label = (firstques?.object(at: Index) as! NSDictionary).value(forKey: "label")as! String
        self.mQuestionLbl.text! = label
        
        let quesarr = (firstques?.object(at: Index) as! NSDictionary).value(forKey: "options")as! NSArray
        self.optionsArry = Options.modelsFromDictionaryArray(array: quesarr)
        self.mQuickTblView.reloadData()
    }
    
    
    
    
}

extension QuickQuizVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.optionsArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "QuickQuizTblCellID", for: indexPath) as! QuickQuizTblCell
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = view
        
        let options = self.optionsArry[indexPath.row]
        //let answer = options.text
        cell.mNameLbl.text = options.text
            //self.NameArry[indexPath.row]
        cell.mImageView.image = UIImage(named:self.ImageArry[indexPath.row])
        cell.mImageView.tag = indexPath.row
        
        return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
            
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "QuickQuizTblCellID", for: indexPath) as! QuickQuizTblCell
        
        let cell = mQuickTblView.cellForRow(at: indexPath)  as! QuickQuizTblCell
        cell.mImageView.image = #imageLiteral(resourceName: "pinkTick")
        let CheckCorrectAns = self.optionsArry[indexPath.row].isCorrect
        if CheckCorrectAns == 1{
           
            isCorrectIntArr.append(CheckCorrectAns!)
            print(isCorrectIntArr.count)
            Constants.kUserDefaults.set(isCorrectIntArr.count, forKey: appConstants.isCorrect)
        }else{
            
        }

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
       let cell = mQuickTblView.cellForRow(at: indexPath)  as! QuickQuizTblCell
         cell.mImageView.image = #imageLiteral(resourceName: "tick")
    }
    
    
    
}
