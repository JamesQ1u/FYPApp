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

class Mark1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var technicalPresentationScore: UITextField!
    @IBOutlet weak var entertainmentValueScore: UITextField!

    @IBOutlet weak var b: UIPickerView!
    
    var urlName:String?
    let db = Firestore.firestore()
    
 
    let data = ["0.1","0.5","0.9","1.3","1.7"]
    let data1 = ["0.1","0.2","0.9","1.3","1.7"]
    override func viewDidLoad() {
        super.viewDidLoad()

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        technicalPresentationScore.inputAccessoryView = toolbar
        entertainmentValueScore.inputAccessoryView = toolbar
        
        //piker view
        let a = UIPickerView()
        let b = UIPickerView()
        a.delegate = self
        a.dataSource = self
        b.delegate = self
        b.dataSource = self
        
        technicalPresentationScore.inputView = a
        technicalPresentationScore.text = data[0]
        technicalPresentationScore.tag = 100
        entertainmentValueScore.inputView = b
        entertainmentValueScore.text = data1[0]
        entertainmentValueScore.tag = 100
        
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(Mark1ViewController.hideKeyBoard(tapG:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return data.count
        }
        return data1.count
        
    
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView = UIPickerView("a"){
            return data[row]
        }
        return data1[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let technicalPresentationScore = self.view?.viewWithTag(100) as? UITextField
        technicalPresentationScore?.text = data[row]
        let entertainmentValueScore = self.view?.viewWithTag(100) as? UITextField
        entertainmentValueScore?.text = data1[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func hideKeyBoard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    

}
