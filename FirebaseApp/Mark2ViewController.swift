//
//  Mark2ViewController.swift
//  FirebaseApp
//
//  Created by james on 14/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Mark2ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    


    @IBOutlet weak var difficultyScore: UITextField!
    @IBOutlet weak var densityScore: UITextField!

    @IBOutlet weak var Event: UILabel!
    var urlName:String?
    var currentSelectItem:String?
    var currentUID:String?
    var content:String?
    
    var multiples:String?
    var displacementSkills:String?
    var spatialDynamics:String?
    var ropeManipulationSkill:String?
    var timeViolations:String?
    var spaceViolations:String?
    var accuracyDeductions:String?
    var technicalPresentationScore:String?
    var entertainmentValueScore:String?
    
    let db = Firestore.firestore()
    var database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8"]]
    var database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.1","0.2","0.3","0.4"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        difficultyScore.inputAccessoryView = toolbar
        densityScore.inputAccessoryView = toolbar

        //picker view
        let a = UIPickerView()
        let b = UIPickerView()
        a.dataSource = self
        a.delegate = self
        b.dataSource = self
        b.delegate = self
        
        difficultyScore.inputView = a
        densityScore.inputView = b
        
        difficultyScore.text = "0"
        densityScore.text = "0"
        
        // hide keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(Mark2ViewController.hideKeyboard(tapG:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        Event.text = currentSelectItem!
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows = database1[component].count
        
        if pickerView == difficultyScore.inputView {
            countrows = database[component].count
            return countrows
            
        }
        
        return countrows
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == difficultyScore.inputView{
            return database[component][row]
            
        }else if pickerView == densityScore.inputView{
            return database1[component][row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == difficultyScore.inputView{
            if component == 0{
                if row == 0{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8"]]
                    self.difficultyScore.inputView?.reloadInputViews()
                    
                }else if row == 1{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6"]]
                    self.difficultyScore.inputView?.reloadInputViews()
                }else if row == 2{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["1.7", "1.8", "1.9", "2.0", "2.1", "2.2", "2.3", "2.4"]]
                    self.difficultyScore.inputView?.reloadInputViews()
                }else if row == 3{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["2.5", "2.6", "2.7", "2.8", "2.9", "3.0", "3.1", "3.2"]]
                    self.difficultyScore.inputView?.reloadInputViews()
                }else if row == 4{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["3.3", "3.4", "3.5", "3.6", "3.7", "3.8", "3.9", "4.0"]]
                    self.difficultyScore.inputView?.reloadInputViews()
                }
                
            }else{
                let data = database[component][row]
                self.difficultyScore.text = data
            }
        }else if pickerView == densityScore.inputView{
            if component == 0{
                if row == 0{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.1","0.2","0.3","0.4"]]
                    self.densityScore.inputView?.reloadInputViews()
                    
                }else if row == 1{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.5","0.6","0.7","0.8"]]
                    self.densityScore.inputView?.reloadInputViews()
                }else if row == 2{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.9","1.0","1.1","1.2"]]
                    self.densityScore.inputView?.reloadInputViews()
                }else if row == 3{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["1.3","1.4","1.5","1.6"]]
                    self.densityScore.inputView?.reloadInputViews()
                }else if row == 4{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["1.7","1.8","1.9","2.0"]]
                    self.densityScore.inputView?.reloadInputViews()
                }
                //technicalPresentationScore.text = self.level[row]
            }else{
                let data = database1[component][row]
                self.densityScore.text = data
            }
        }
    }
    
    @IBAction func updateData(_ sender: UIButton){

        
        content = """
        Multiples: \(String(describing: multiples!))
        Displacement Skills: \(String(describing: displacementSkills!))
        Spatial Dynamics: \(String(describing: spatialDynamics!))
        Rope ManipulationSkill: \(String(describing: ropeManipulationSkill!))
        Time Violations: \(String(describing: timeViolations!))
        Space Violations: \(String(describing: spaceViolations!))
        Accuracy Deductions: \(String(describing: accuracyDeductions!))
        Technical Presentation Score: \(String(describing: technicalPresentationScore!))
        Entertainment ValueScore: \(String(describing: entertainmentValueScore!))
        Difficulty Score: \(String(describing: self.difficultyScore.text!))
        Density Score: \(String(describing: self.densityScore.text!))
        """
        
        let confirmAlert = UIAlertController(title: "Confirmation", message: self.content, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Confirm", style: .default){(Void) in
            let docData: [String: Any] = [
                
                "multiples": self.multiples as Any,
                "displacementSkills": self.displacementSkills as Any,
                "spatialDynamics": self.spatialDynamics as Any,
                "ropeManipulationSkill": self.ropeManipulationSkill as Any,
                "timeViolations": self.timeViolations as Any,
                "spaceViolations": self.spaceViolations as Any,
                "accuracyDeductions": self.accuracyDeductions as Any,
                "technicalPresentationScore": self.technicalPresentationScore as Any,
                "entertainmentValueScore": self.entertainmentValueScore as Any,
                "difficultyScore": self.difficultyScore.text as Any,
                "densityScore": self.densityScore.text as Any,
                "JudgeId": Auth.auth().currentUser?.uid as Any,
                
                ]
            
            self.db.collection("competition").document(self.currentUID!).collection("competitionItem").document(self.currentSelectItem!).collection("participantCollection").document(self.urlName!).updateData(docData)

        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default){(Void) in
            
            confirmAlert.dismiss(animated: true, completion: nil)
        }
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        present(confirmAlert, animated: true, completion: nil)
        
    }
    
    
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 按空白處會隱藏編輯狀態
    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    

}

//extension Mark2ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 2
//    }
//
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        if component == 0{
//            return dataSource.count
//        }
//
//        return dataSource1.count
//    }
//
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if component == 0{
//            difficultyScore.text = dataSource[row]
//        }else{
//            densityScore.text = dataSource1[row]
//        }
//
//}
//
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        if component == 0{
//            return dataSource[row]
//        }else{
//            return dataSource1[row]}
//    }
//
//}
