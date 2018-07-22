//
//  Speed2MarkViewController.swift
//  FirebaseApp
//
//  Created by james on 20/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Speed2MarkViewController: UIViewController {
    @IBOutlet weak var judge1: UITextField!
    @IBOutlet weak var judge2: UITextField!
    @IBOutlet weak var judge3: UITextField!
    @IBOutlet weak var techinicalJudge: UITextField!
    
    @IBOutlet weak var Event: UILabel!
    
    var urlName:String?
    var currentSelectItem:String?
    var currentUID:String?
    let db = Firestore.firestore()
    var content:String?
    
    var spaceViolations:String?
    var falseStart:String?
    var falseSwitch:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        judge1.inputAccessoryView = toolbar
        judge2.inputAccessoryView = toolbar
        judge3.inputAccessoryView = toolbar
        techinicalJudge.inputAccessoryView = toolbar
        // Do any additional setup after loading the view.
        judge1.text = "0"
        judge2.text = "0"
        judge3.text = "0"
        techinicalJudge.text = "0"
        
        judge1.keyboardType = .numberPad
        judge2.keyboardType = .numberPad
        judge3.keyboardType = .numberPad
        techinicalJudge.keyboardType = .numberPad
        
        Event.text = currentSelectItem!
        
        //alert controller size

        
    }

    @IBAction func updateData(_ sender: UIButton){
        
        
        content = """
        Space Violations: \(String(describing: spaceViolations!))
        False Start: \(String(describing: falseStart!))
        False Switch: \(String(describing: falseSwitch!))
        Judge1: \(String(describing: self.judge1.text!))
        Judge2: \(String(describing: self.judge2.text!))
        Judge3: \(String(describing: self.judge3.text!))
        Techinical Judge: \(String(describing: self.techinicalJudge.text!))
        """
        
        let confirmAlert = UIAlertController(title: "Confirmation", message: self.content, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Confirm", style: .default){(Void) in
            let docData: [String: Any] = [
                "spaceViolations": self.spaceViolations as Any,
                "falseStart": self.falseStart as Any,
                "falseSwitch": self.falseSwitch as Any,
                "judge1": self.judge1.text as Any,
                "judge2": self.judge2.text as Any,
                "judge3": self.judge3.text as Any,
                "techinicalJudge": self.techinicalJudge.text as Any,
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
    @IBAction func Judge1(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        judge1.text = String(number)
    }
    @IBAction func Judge2(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        judge2.text = String(number)
    }
    @IBAction func Judge3(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        judge3.text = String(number)
    }

    @IBAction func TechnicalJudge(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        techinicalJudge.text = String(number)
    }
    

    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

}
