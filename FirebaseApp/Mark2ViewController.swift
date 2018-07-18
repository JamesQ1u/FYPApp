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

class Mark2ViewController: UIViewController {

    @IBOutlet weak var difficultyScore: UILabel!
    @IBOutlet weak var a: UIPickerView!
    @IBOutlet weak var densityScore: UILabel!
    @IBOutlet weak var b: UIPickerView!
    
    private let dataSource = ["0.1","0.9","1.7","2.5","3.3"]
    private let dataSource1 = ["0.1","0.5","0.9","1.3","1.7"]
    var urlName:String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        //difficultyScore.inputAccessoryView = toolbar
        //densityScore.inputAccessoryView = toolbar

        //picker view
        a.dataSource = self
        a.delegate = self

        
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
    
//    @IBAction func stepper(_ sender: UIStepper) {
//
//        var number = 0
//        number = Int(sender.value)
//        difficultyScore.text = String(number)
//    }
//
    
    
    @objc func doneClicked(){
        view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension Mark2ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return dataSource.count
        }
        
        return dataSource1.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0{
            difficultyScore.text = dataSource[row]
        }else{
            densityScore.text = dataSource1[row]
        }
        
}
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return dataSource[row]
        }else{
            return dataSource1[row]}
    }
 
}
