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

    @IBOutlet weak var multiples: UITextField!
    @IBOutlet weak var displacementSkills: UITextField!
    @IBOutlet weak var spatialDynamics: UITextField!
    @IBOutlet weak var ropeManipulationSkill: UITextField!
    
    @IBOutlet weak var timeViolations: UITextField!
    @IBOutlet weak var spaceViolations: UITextField!
    @IBOutlet weak var accuracyDeductions: UITextField!
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        multiples.inputAccessoryView = toolbar
        displacementSkills.inputAccessoryView = toolbar
        spatialDynamics.inputAccessoryView = toolbar
        ropeManipulationSkill.inputAccessoryView = toolbar
        timeViolations.inputAccessoryView = toolbar
        spaceViolations.inputAccessoryView = toolbar
        accuracyDeductions.inputAccessoryView = toolbar

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "multiples": self.multiples.text as Any,
            "displacementSkills": self.displacementSkills.text as Any,
            "spatialDynamics": self.spatialDynamics.text as Any,
            "ropeManipulationSkill": self.ropeManipulationSkill.text as Any,
            "timeViolations": self.timeViolations.text as Any,
            "spaceViolations": self.spaceViolations.text as Any,
            "accuracyDeductions": self.accuracyDeductions.text as Any,
            
            ]
        
        db.collection("competition").document("jTtJBKOrspSdd1iNaOi0")
            .collection("participant").document().updateData(docData)
        
        let alertController = UIAlertController(title: "Successful!",
         message: nil, preferredStyle: .alert)
         self.present(alertController, animated: true, completion: nil)
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
         self.presentedViewController?.dismiss(animated: false, completion: nil)
         }
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
