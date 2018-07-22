//
//  Mark3ViewController.swift
//  FirebaseApp
//
//  Created by james on 15/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Mark3ViewController: UIViewController {
    var urlName:String?
    var currentSelectItem:String?
    var currentUID:String?
    var multiples:String?
    var displacementSkills:String?
    var spatialDynamics:String?
    var ropeManipulationSkill:String?
    

    
    @IBOutlet weak var timeViolations: UITextField!
    @IBOutlet weak var spaceViolations: UITextField!
    @IBOutlet weak var accuracyDeductions: UITextField!
    
    @IBOutlet weak var Event: UILabel!
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        timeViolations.inputAccessoryView = toolbar
        spaceViolations.inputAccessoryView = toolbar
        accuracyDeductions.inputAccessoryView = toolbar
        
        timeViolations.text = "0"
        spaceViolations.text = "0"
        accuracyDeductions.text = "0"
        
        timeViolations.keyboardType = .numberPad
        spaceViolations.keyboardType = .numberPad
        accuracyDeductions.keyboardType = .numberPad
        
        Event.text = currentSelectItem!
        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateData(_ sender: UIButton){
//        let docData: [String: Any] = [
//
//            "timeViolations": self.timeViolations.text as Any,
//            "spaceViolations": self.spaceViolations.text as Any,
//            "accuracyDeductions": self.accuracyDeductions.text as Any,
//
//            ]
//
//        db.collection("competition").document(currentUID!).collection("competitionItem").document(currentSelectItem!).collection("participantCollection").document(urlName!).updateData(docData)
        
        self.performSegue(withIdentifier: "UID", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UID"{
            let mark = segue.destination as! Mark1ViewController
            mark.currentUID = self.currentUID
            mark.urlName = self.urlName
            mark.currentSelectItem  = self.currentSelectItem
            mark.multiples = self.multiples
            mark.displacementSkills = self.displacementSkills
            mark.spatialDynamics = self.spatialDynamics
            mark.ropeManipulationSkill = self.ropeManipulationSkill
            mark.timeViolations = self.timeViolations.text
            mark.spaceViolations = self.timeViolations.text
            mark.accuracyDeductions = self.accuracyDeductions.text
            
        }
        
    }
    

    @IBAction func TimeViolations(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        timeViolations.text = String(number)
    }
    @IBAction func SpaceViolations(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        spaceViolations.text = String(number)
    }
    @IBAction func AccuracyDeductions(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        accuracyDeductions.text = String(number)
    }
    
    
    @objc func doneClicked(){
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
