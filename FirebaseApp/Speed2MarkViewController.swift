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
import FirebaseAuth
import MediaPlayer
import AVFoundation
import FirebaseAuth

class Speed2MarkViewController: UIViewController {
    @IBOutlet weak var judge1: UITextField!
    @IBOutlet weak var judge2: UITextField!
    @IBOutlet weak var judge3: UITextField!
    @IBOutlet weak var techinicalJudge: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var judge1UIStepper: UIStepper!

    @IBOutlet weak var judge2UIStepper: UIStepper!
    @IBOutlet weak var judge3UIStepper: UIStepper!
    @IBOutlet weak var techinicalJudgeUIStepper: UIStepper!
   
    @IBOutlet weak var Event: UILabel!
    
    var urlName:String?
    var currentSelectItem:String?
    var currentUID:String?
    let db = Firestore.firestore()
    var content:String?
    
   
    
    var spaceViolations:String?
    var falseStart:String?
    var falseSwitch:String?
    var totalMark:Double?
    var a:Double?
    var b:Double?
    var c:Double?
    var d:Double?
    var e:Double?
    var f:Double?
    var g:Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         submitBtn.layer.cornerRadius = 20
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
        /// Volume View
        /// Volume View
//        let volumeView = MPVolumeView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        volumeView.isHidden = false
//        volumeView.alpha = 0.01
//        view.addSubview(volumeView)
        
        /// Notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.volumeDidChange(notification:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)
        
        
        
    }
    @objc func volumeDidChange(notification: NSNotification) {
        judge1UIStepper.value += 1
        judge1.text = String(Int(judge1UIStepper.value))
        
        judge2UIStepper.value += 1
        judge2.text = String(Int(judge2UIStepper.value))
        
        judge3UIStepper.value += 1
        judge3.text = String(Int(judge3UIStepper.value))
        
        techinicalJudgeUIStepper.value += 1
        techinicalJudge.text = String(Int(techinicalJudgeUIStepper.value))
        
        
    }
    @IBAction func updateData(_ sender: UIButton){
        //string type change to number
        a = Double(self.spaceViolations!)
        b = Double(self.falseStart!)
        c = Double(self.falseSwitch!)
        d = Double(self.judge1.text!)
        e = Double(self.judge2.text!)
        f = Double(self.judge3.text!)
        g = Double(self.techinicalJudge.text!)
        totalMark =  (d!+e!+f!+g!)/2-(a! + b! + c!)*5
        
        content = """
        Space Violations: \(String(describing: spaceViolations!))
        False Start: \(String(describing: falseStart!))
        False Switch: \(String(describing: falseSwitch!))
        Judge1: \(String(describing: self.judge1.text!))
        Judge2: \(String(describing: self.judge2.text!))
        Judge3: \(String(describing: self.judge3.text!))
        Techinical Judge: \(String(describing: self.techinicalJudge.text!))
        Total Mark: \(String(describing: totalMark!))
        """
        
        
        
        let confirmAlert = UIAlertController(title: "Confirmation", message: self.content, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: "Confirm", style: .default){(Void) in
            let docData: [String: Any] = [
                "spaceViolations": self.a as Any,
                "falseStart": self.b as Any,
                "falseSwitch": self.c as Any,
                "judge1": self.d as Any,
                "judge2": self.e as Any,
                "judge3": self.f as Any,
                "techinicalJudge": self.g as Any,
                "JudgeId": Auth.auth().currentUser?.uid as Any,
                "TotalMark": self.totalMark as Any,
                ]
            self.db.collection("competition").document(self.currentUID!).collection("competitionItem").document(self.currentSelectItem!).collection("participantCollection").document(self.urlName!).updateData(docData)
            
            let home = self.navigationController?.viewControllers[0]
            self.navigationController?.popToViewController(home as! HomeViewController, animated: true)
            
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default){(Void) in
            
            confirmAlert.dismiss(animated: true, completion: nil)
        }
        
        confirmAlert.addAction(confirm)
        confirmAlert.addAction(cancel)
        present(confirmAlert, animated: true, completion: nil)
        
    }
    @IBAction func Judge1(_ sender: UIStepper) {

        judge1.text = String(Int(judge1UIStepper.value))
    }
    @IBAction func Judge2(_ sender: UIStepper) {
          judge2.text = String(Int(judge2UIStepper.value))
    }
    @IBAction func Judge3(_ sender: UIStepper) {
          judge3.text = String(Int(judge3UIStepper.value))
    }

    @IBAction func TechnicalJudge(_ sender: UIStepper) {
        techinicalJudge.text = String(Int(techinicalJudgeUIStepper.value))
    }
    

    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    

}
