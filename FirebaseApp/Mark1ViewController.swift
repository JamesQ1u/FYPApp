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


class Mark1ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {


    @IBOutlet weak var technicalPresentationScore: UITextField!
    @IBOutlet weak var entertainmentValueScore: UITextField!

    @IBOutlet weak var a: UIPickerView!
    @IBOutlet weak var b: UIPickerView!
    
    var urlName:String?
    let db = Firestore.firestore()
    
 
    let data = ["0.1","0.5","0.9","1.3","1.7"]
    let data1 = ["0.1","0.2","0.9","1.3","1.7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //done buuton

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        toolbar.setItems([doneButton], animated: false)
        technicalPresentationScore.inputAccessoryView = toolbar
        entertainmentValueScore.inputAccessoryView = toolbar
        

        //textfiled
        technicalPresentationScore.text = data[0]
        entertainmentValueScore.text = data1[0]

        
    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "technicalPresentationScore": self.technicalPresentationScore.text as Any,
            "entertainmentValueScore": self.entertainmentValueScore.text as Any,
            
            ]
        
        db.collection("competition").document("jTtJBKOrspSdd1iNaOi0")
            .collection("participant").document(urlName!).updateData(docData)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(Mark1ViewController.hideKeyboard(tapG:)))
//        tap.cancelsTouchesInView = false
//        self.view.addGestureRecognizer(tap)
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
        
            return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var countrows : Int = data.count
        if pickerView == b{
            countrows = self.data1.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == b{
            let titleRow = data1[row]
            return titleRow
        }else if pickerView == a{
            let titleRow = data[row]
            return titleRow
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == b{
            
                self.technicalPresentationScore.text = self.data1[row]
                self.b.isHidden = true
        }else if pickerView == a{
            
                self.entertainmentValueScore.text = self.data[row]
                self.a.isHidden = true
        }
    }
    func textFieldDidBeginEditing(_ textField:UITextField){
        if(textField == self.technicalPresentationScore){
            self.a.isHidden = false
        }else if (textField == self.entertainmentValueScore){
            self.b.isHidden = false
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
//        self.view.endEditing(true)
//    }

    

}
