//
//  MarkViewController.swift
//  FirebaseApp
//
//  Created by james on 7/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class MarkViewController: UIViewController {

    @IBOutlet weak var spaceViolations: UITextField!
    @IBOutlet weak var falseStart: UITextField!
    @IBOutlet weak var falseSwitch: UITextField!


    
    
    
    var urlName:String?
    var currentSelectItem:String?
    var currentUID:String?
    let db = Firestore.firestore()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
                spaceViolations.inputAccessoryView = toolbar
                falseStart.inputAccessoryView = toolbar
                falseSwitch.inputAccessoryView = toolbar

        spaceViolations.text = "0"
        falseStart.text = "0"
        falseSwitch.text = "0"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "spaceViolations": self.spaceViolations.text as Any,
            "falseStart": self.falseStart.text as Any,
            "falseSwitch": self.falseSwitch.text as Any,


        ]
        
        db.collection("competition").document(currentUID!)
            .collection("competitionItem").document("四人Quadruple4x30secOpen二重速度跳接力比賽9-12").collection("participantCollection").document(urlName!).updateData(docData)
        
        let alertController = UIAlertController(title: "Successful!",
                                                message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UID"{
            let mark = segue.destination as! Speed2MarkViewController
            mark.currentUID = self.currentUID
            mark.currentSelectItem = self.currentSelectItem
            mark.urlName = self.urlName
            
        }
        
    }
    @IBAction func SpaceViolations(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        spaceViolations.text = String(number)
    }
    
    @IBAction func FalseStart(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        falseStart.text = String(number)
    }
    
    @IBAction func FalseSwitch(_ sender: UIStepper) {
        var number = 0
        number = Int(sender.value)
        falseSwitch.text = String(number)
    }
    
    
    
    @IBAction func mark(_ sender: UIButton){
        self.performSegue(withIdentifier: "UID", sender: nil)
        
    }

    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
