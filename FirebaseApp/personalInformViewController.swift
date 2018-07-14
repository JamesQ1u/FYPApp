//
//  personalInformViewController.swift
//  QRcode
//
//  Created by Anson on 27/3/2018.
//  Copyright © 2018年 HKRedCross. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class personalInformViewController: UIViewController {

    @IBOutlet weak var UID: UILabel!
    @IBOutlet weak var EName: UILabel!
    @IBOutlet weak var CName: UILabel!
    @IBOutlet weak var showCompetition: UITableView!
    
    @IBOutlet weak var back: UIBarButtonItem!
    
    var urlName:String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UID.text = urlName
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loadData(_ sender: UIButton){
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
        
        let mark = segue.destination as! MarkViewController
        mark.urlName = self.urlName
        
        
        
       
    }
        
    @IBAction func mark(_ sender: UIButton){
        self.performSegue(withIdentifier: "UID", sender: self)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "MarkViewController") as! MarkViewController
        self.present(nextViewController, animated: true, completion: nil)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension personalInformViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = " Noel is good"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
    }
    
    
}


