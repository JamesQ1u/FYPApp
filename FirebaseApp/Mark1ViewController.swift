//
//  Mark1ViewController.swift
//  FirebaseApp
//
//  Created by james on 14/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class Mark1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {


    @IBOutlet weak var technicalPresentationScore: UITextField!
    @IBOutlet weak var entertainmentValueScore: UITextField!

    
    var urlName:String?
    var currentSelectItem:String?
    var currentUID:String?
    let db = Firestore.firestore()
    var database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8"]]
    var database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.1","0.2","0.3","0.4"]]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //done buuton

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        technicalPresentationScore.inputAccessoryView = toolbar
        entertainmentValueScore.inputAccessoryView = toolbar
        

        //textfiled
        let a = UIPickerView()
        let b = UIPickerView()
        a.dataSource = self
        a.delegate = self
        b.dataSource = self
        b.delegate = self
        
        technicalPresentationScore.inputView = a
        entertainmentValueScore.inputView = b
        
        technicalPresentationScore.text = "0"
        entertainmentValueScore.text = "0"

        //hide keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(Mark1ViewController.hideKeyboard(tapG:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "technicalPresentationScore": self.technicalPresentationScore.text as Any,
            "entertainmentValueScore": self.entertainmentValueScore.text as Any,
            
            ]
        
        db.collection("competition").document(currentUID!).collection("competitionItem").document("個人Personal30secMale花式比賽7-8").collection("participantCollection").document(urlName!).updateData(docData)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let mark = segue.destination as! Mark2ViewController
        mark.currentUID = self.currentUID
        mark.urlName = self.urlName
        
    }
    @IBAction func mark(_ sender: UIButton){
        self.performSegue(withIdentifier: "UID", sender: self)

    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {

            return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows = database1[component].count
        
        if pickerView == technicalPresentationScore.inputView {
            countrows = database[component].count
           return countrows
            
        }
        
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == technicalPresentationScore.inputView{
            return database[component][row]
            
        }else if pickerView == entertainmentValueScore.inputView{
            return database1[component][row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == technicalPresentationScore.inputView{
            if component == 0{
                if row == 0{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8"]]
                    self.technicalPresentationScore.inputView?.reloadInputViews()
                    
                }else if row == 1{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6"]]
                    self.technicalPresentationScore.inputView?.reloadInputViews()
                }else if row == 2{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["1.7", "1.8", "1.9", "2.0", "2.1", "2.2", "2.3", "2.4"]]
                    self.technicalPresentationScore.inputView?.reloadInputViews()
                }else if row == 3{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["2.5", "2.6", "2.7", "2.8", "2.9", "3.0", "3.1", "3.2"]]
                    self.technicalPresentationScore.inputView?.reloadInputViews()
                }else if row == 4{
                    database = [["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"],["3.3", "3.4", "3.5", "3.6", "3.7", "3.8", "3.9", "4.0"]]
                    self.technicalPresentationScore.inputView?.reloadInputViews()
                }
    
            }else{
                let data = database[component][row]
                self.technicalPresentationScore.text = data
            }
            
            
        }else if pickerView == entertainmentValueScore.inputView{
            if component == 0{
                if row == 0{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.1","0.2","0.3","0.4"]]
                    self.entertainmentValueScore.inputView?.reloadInputViews()
                    
                }else if row == 1{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.5","0.6","0.7","0.8"]]
                    self.entertainmentValueScore.inputView?.reloadInputViews()
                }else if row == 2{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["0.9","1.0","1.1","1.2"]]
                    self.entertainmentValueScore.inputView?.reloadInputViews()
                }else if row == 3{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["1.3","1.4","1.5","1.6"]]
                    self.entertainmentValueScore.inputView?.reloadInputViews()
                }else if row == 4{
                    database1 = [["Basic","Elementary","Intermediate", "Advanced", "Masters"],["1.7","1.8","1.9","2.0"]]
                    self.entertainmentValueScore.inputView?.reloadInputViews()
                }
                //technicalPresentationScore.text = self.level[row]
            }else{
                let data = database1[component][row]
                self.entertainmentValueScore.text = data
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    

}
