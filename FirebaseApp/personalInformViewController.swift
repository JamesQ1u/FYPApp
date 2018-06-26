//
//  personalInformViewController.swift
//  QRcode
//
//  Created by Anson on 27/3/2018.
//  Copyright © 2018年 HKRedCross. All rights reserved.
//

import UIKit
import Firebase

class personalInformViewController: UIViewController {
    @IBOutlet weak var UID: UITextField!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var lname: UITextField!
    @IBOutlet weak var chName: UITextField!
    @IBOutlet weak var HKID: UITextField!
    @IBOutlet weak var DOB: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var Height: UITextField!
    @IBOutlet weak var bGroup: UITextField!
    @IBOutlet weak var DID: UITextField!

    @IBOutlet weak var hkHave: UITextField!
    @IBOutlet weak var from: UITextField!
    @IBOutlet weak var lastDdate: UITextField!
    
    var urlName:String?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
      
       

        UID.text = urlName
        super.viewDidLoad()
       
       
      
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loadData(_ sender: UIButton) {
        ref = Database.database().reference()
        ref.child("user").child(UID.text!).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let key = snap.key
                var value = snap.value
                switch key {
                case ("firstName"):
                    self.fName.text = "\(value!)"
                case ("blood_group"):
                    self.bGroup.text = "\(value!)"
                case ("chinese_name"):
                    self.chName.text = "\(value!)"
                case ("DOB"):
                    self.chName.text = "\(value!)"
                case ("HKID"):
                    self.HKID.text = "\(value!)"
                case ("height"):
                    self.Height.text = "\(value!)"
                case ("finishQC"):
                    let ram = "\(value!)"
                    if (ram == "1"){
                    self.from.text = "Yes"
                    }else{
                        self.from.text = "No"
                    }
                case ("whether_donated_blood"):
                    self.hkHave.text = "\(value!)"
                case ("date_brith"):
                    self.DOB.text = "\(value!)"
                case ("lastName"):
                    self.lname.text = "\(value!)"
                case ("weight"):
                    self.weight.text = "\(value!)"
                case ("last_donation_date"):
                    self.lastDdate.text = "\(value!)"
                default:
                    break
                }
                
                print("key = \(key)  value = \(value!)")
            }
        })
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
