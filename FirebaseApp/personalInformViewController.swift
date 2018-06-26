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
    @IBOutlet weak var EName: UITextField!
    @IBOutlet weak var CName: UITextField!

    
    
    
    
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
                let value = snap.value
                switch key {
                case ("firstName"):
                    self.EName.text = "\(value!)"
                case ("chinese_name"):
                    self.CName.text = "\(value!)"
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
