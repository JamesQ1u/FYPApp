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
    @IBOutlet weak var totalDeductions: UITextField!
    @IBOutlet weak var judge1: UITextField!
    @IBOutlet weak var judge2: UITextField!
    @IBOutlet weak var judge3: UITextField!
    @IBOutlet weak var techinicalJudge: UITextField!
    
    
    var urlName:String?
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
                totalDeductions.inputAccessoryView = toolbar
                judge1.inputAccessoryView = toolbar
                judge2.inputAccessoryView = toolbar
                judge3.inputAccessoryView = toolbar
                techinicalJudge.inputAccessoryView = toolbar

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "spaceViolations": self.spaceViolations.text as Any,
            "falseStart": self.falseStart.text as Any,
            "falseSwitch": self.falseSwitch.text as Any,
            "totalDeductions": self.totalDeductions.text as Any,
            "judge1": self.judge1.text as Any,
            "judge2": self.judge2.text as Any,
            "judge3": self.judge3.text as Any,
            "techinicalJudge": self.techinicalJudge.text as Any,
        ]
        
        db.collection("competition").document("jTtJBKOrspSdd1iNaOi0")
            .collection("participant").document(urlName!).updateData(docData)
        
        /*let alertController = UIAlertController(title: "Successful!",
                                                message: nil, preferredStyle: .alert)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let mark = segue.destination as! Mark1ViewController
        mark.urlName = self.urlName
        
    }
    @IBAction func mark(_ sender: UIButton){
        self.performSegue(withIdentifier: "UID", sender: self)
        

        
    }
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}
