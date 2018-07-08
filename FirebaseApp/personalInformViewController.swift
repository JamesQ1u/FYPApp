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
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UID.text = urlName
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loadData(_ sender: UIButton) {
        db.collection("competition").document("jTtJBKOrspSdd1iNaOi0").collection("participant").document(UID.text!).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            if let Ename = document.data()!["EName"] as? String{
                self.EName.text = "\(Ename)"
            }
            if let Cname = document.data()!["CName"] as? String{
                self.CName.text = "\(Cname)"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "name"){
            let mark = segue.destination as! MarkViewController
            mark.urlName = self.urlName
        }
        
        /*if (segue.identifier == "competition"){
        let competition = segue.destination as! CompetitionViewController
        competition.urlName = self.urlName
        }*/
    }
    
    @IBAction func mark(_ sender: UIButton){
        self.performSegue(withIdentifier: "name", sender: self)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MarkViewController") as! MarkViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    /*@IBAction func competition(_ sender: UIButton){
        self.performSegue(withIdentifier: "competition", sender: self)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CompetitionViewController") as! CompetitionViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }*/
    

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
