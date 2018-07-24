//
//  Mark4ViewController.swift
//  FirebaseApp
//
//  Created by james on 21/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class Mark4ViewController: UIViewController {

    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var selectMultiples: UISegmentedControl!
    @IBOutlet weak var selectdiSplacementSkills: UISegmentedControl!
    @IBOutlet weak var selectSpatialDynamics: UISegmentedControl!
    @IBOutlet weak var selectRopeManipulationSkill: UISegmentedControl!
    
    @IBOutlet weak var Event: UILabel!
    
    var urlName:String?
    var currentUID: String?
    var currentSelectItem:String?
    let db = Firestore.firestore()
    
    var a = "0"
    var b = "0"
    var c = "0"
    var d = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 0.5
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        Event.text = currentSelectItem!
    }
    
    @IBAction func updateData(_ sender: UIButton){
//        let docData: [String: Any] = [
//            
//            "multiples": a as Any,
//            "displacementSkills": b as Any,
//            "spatialDynamics": c as Any,
//            "ropeManipulationSkill": d as Any,
//            
//            ]
//        
//        db.collection("competition").document(currentUID!).collection("competitionItem").document(currentSelectItem!).collection("participantCollection").document(urlName!).updateData(docData)
        
            self.performSegue(withIdentifier: "UID", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UID"{
            let mark = segue.destination as! Mark3ViewController
            mark.urlName = self.urlName
            mark.currentUID = self.currentUID
            mark.currentSelectItem  = self.currentSelectItem
            mark.multiples = self.a
            mark.displacementSkills = self.b
            mark.spatialDynamics = self.c
            mark.ropeManipulationSkill = self.d
        }
        
    }
    
    @IBAction func selectMultiples(_ sender: UISegmentedControl) {
        
        let getIndex = selectMultiples.selectedSegmentIndex
        
        switch (getIndex){
        case 0:
            a = "0"
        case 1:
            a = "0.2"
        case 2:
            a = "0.4"
        default:
            print("no")
        }
    }
    
    @IBAction func selectdiSplacementSkills(_ sender: UISegmentedControl) {
        let getIndex = selectdiSplacementSkills.selectedSegmentIndex
        
        switch (getIndex){
        case 0:
            b = "0"
        case 1:
            b = "0.2"
        case 2:
            b = "0.4"
        default:
            print("no")
        }
    }
    
    @IBAction func selectSpatialDynamics(_ sender: UISegmentedControl) {
        let getIndex = selectSpatialDynamics.selectedSegmentIndex
        
        switch (getIndex){
        case 0:
            c = "0"
        case 1:
            c = "0.2"
        case 2:
            c = "0.4"
        default:
            print("no")
        }
    }
    
    @IBAction func selectRopeManipulationSkill(_ sender: UISegmentedControl) {
        let getIndex = selectRopeManipulationSkill.selectedSegmentIndex
        
        switch (getIndex){
        case 0:
            d = "0"
        case 1:
            d = "0.2"
        case 2:
            d = "0.4"
        default:
            print("no")
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
