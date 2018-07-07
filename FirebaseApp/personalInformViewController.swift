//
//  personalInformViewController.swift
//  QRcode
//
//  Created by Anson on 27/3/2018.
//  Copyright © 2018年 HKRedCross. All rights reserved.
//

import UIKit
import Firebase
struct CellDate {
    let image : UIImage?
    let message: String?
}
class personalInformViewController: UITableViewController {
    @IBOutlet weak var UID: UITextField!
    @IBOutlet weak var EName: UITextField!
    @IBOutlet weak var CName: UITextField!
    
    var data = [CellDate]()
    
    var urlName:String?
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        UID.text = urlName
         
        data=[CellDate.init(image:#imageLiteral(resourceName: "jump") , message: "Noel is good")]
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
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
            print("test::")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableView? {
        let cell =  self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        cell.mainImage = data[indexPath.row].image
        cell.message = data[indexPath.row].message
        return cell
    }
    override func tableView(_ tableView:UITableView, numberOfRowsInSection Section: Int) -> Int {
        return data.count
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
