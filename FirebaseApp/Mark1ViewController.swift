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

class Mark1ViewController: UIViewController {

    @IBOutlet weak var technicalPresentationScore: UITextField!
    @IBOutlet weak var entertainmentValueScore: UITextField!
    
    var urlName:String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        technicalPresentationScore.inputAccessoryView = toolbar
        entertainmentValueScore.inputAccessoryView = toolbar

        // Do any additional setup after loading the view.
    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "technicalPresentationScore": self.technicalPresentationScore.text as Any,
            "entertainmentValueScore": self.entertainmentValueScore.text as Any,

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
        
        let mark = segue.destination as! Mark2ViewController
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
