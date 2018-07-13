//
//  Mark2ViewController.swift
//  FirebaseApp
//
//  Created by james on 14/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

class Mark2ViewController: UIViewController {

    @IBOutlet weak var difficultyScore: UITextField!
    @IBOutlet weak var densityScore: UITextField!
    
    var urlName:String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        difficultyScore.inputAccessoryView = toolbar
        densityScore.inputAccessoryView = toolbar

        // Do any additional setup after loading the view.
    }

    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "difficultyScore": self.difficultyScore.text as Any,
            "densityScore": self.densityScore.text as Any,
            
            ]
        
        db.collection("competition").document("jTtJBKOrspSdd1iNaOi0")
            .collection("participant").document(urlName!).updateData(docData)
        
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
