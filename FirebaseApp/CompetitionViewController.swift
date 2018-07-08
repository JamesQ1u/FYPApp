//
//  CompetitionViewController.swift
//  FirebaseApp
//
//  Created by james on 7/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

struct CellDate {
    let image : UIImage?
    let message: String?
}

class CompetitionViewController: UITableViewController {
    
    var urlName:String?
    let db = Firestore.firestore()
    var data = [CellDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data=[CellDate.init(image:#imageLiteral(resourceName: "cross") , message: "Noel is good")]
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell? {
         let cell =  self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
         cell.mainImage = data[indexPath.row].image
         cell.message = data[indexPath.row].message
         return cell
    }
    
    override func tableView(_ tableView:UITableView, numberOfRowsInSection Section: Int) -> Int {
        return data.count
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
