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

    
    var urlName:String?
    let db = Firestore.firestore()
    
    let level = ["Level 1", "Level 2", "Level 3", "Level 4", "Level 5"]
    let level1 = ["0.1", "0.2", "0.3", "0.4", "0.5", "0.6", "0.7", "0.8"]
    let level2 = ["0.9", "1.0", "1.1", "1.2", "1.3", "1.4", "1.5", "1.6"]
    let level3 = ["1.7", "1.8", "1.9", "2.0", "2.1", "2.2", "2.3", "2.4"]
    
    let levels = ["Basic","Elementary","Intermediate", "Advanced", "Masters"]
    let data1 = ["0.1","0.2","0.3","0.4"]
    let data2 = ["0.5","0.6","0.7","0.8"]
    
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
        let a = UIPickerView()
        let b = UIPickerView()
        a.dataSource = self
        a.delegate = self
        b.dataSource = self
        b.delegate = self
        
        technicalPresentationScore.inputView = a
        entertainmentValueScore.inputView = b
        
        technicalPresentationScore.text = level1[0]
        entertainmentValueScore.text = data1[0]

        //hide keyboard
        let tap = UITapGestureRecognizer(target: self, action: #selector(Mark1ViewController.hideKeyboard(tapG:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)

    }
    
    @IBAction func updateData(_ sender: UIButton){
        let docData: [String: Any] = [
            
            "technicalPresentationScore": self.technicalPresentationScore.text as Any,
            "entertainmentValueScore": self.entertainmentValueScore.text as Any,
            
            ]
        
        db.collection("competition").document("jTtJBKOrspSdd1iNaOi0")
            .collection("participant").document(urlName!).updateData(docData)
        
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
        var countrows: Int = 10
        if pickerView == technicalPresentationScore.inputView {
            if component == 0{
                countrows = level.count
                return countrows
            }
            countrows = level1.count
            return countrows
            
        }else if pickerView == entertainmentValueScore.inputView{
            if component == 0{
                countrows = levels.count
                return countrows
            }
            countrows = data1.count
            return countrows
        }
        
        return countrows
        
//        if component == 0 {
//            var countrows : Int = level.count
//            if pickerView == entertainmentValueScore.inputView{
//                countrows = self.levels.count
//            }
//            return countrows
//        }
//        var Scountrows : Int = level1.count
//        if pickerView == entertainmentValueScore.inputView{
//            Scountrows = self.data1.count
//        }
//        return Scountrows
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == technicalPresentationScore.inputView{
            if component == 0 {
                return level[row]
            }
            
            var A = level1[row]
            
            if component == 1{
                
                if component == 0 && level[0] == "Level 1"{
                    A = level1[row]
                }
                if component == 0 && level[1] == "Level 2"{
                    A = level2[row]
                }
                return A
            }
            
            
            
        }else if pickerView == entertainmentValueScore.inputView{
            if component == 0 {
                return levels[row]
            }
            return data1[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == technicalPresentationScore.inputView{
            if component == 0 && row == 0{
                
                self.technicalPresentationScore.text = self.level[row]
            }else{

                self.technicalPresentationScore.text = self.level1[row]
                
            }
            
            
            
        }else if pickerView == entertainmentValueScore.inputView{
            if component == 0{
                self.entertainmentValueScore.text = self.levels[row]
            }else{
                self.entertainmentValueScore.text = self.data1[row]
            }
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func hideKeyboard(tapG:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

    

}
