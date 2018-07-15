//
//  HomeViewController.swift
//  FirebaseApp
//
//  Created by Robert Canton on 2018-02-02.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController:UIViewController {
    
    var enameArray = [String]()
    var startDateArray = [Date]()
    var uidArray = [String]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        let db = Firestore.firestore()
        
        db.collection("competition").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    if let ename = document.data()["name"] as? String{
                        self.enameArray.append(ename)
                    }else{
                        self.enameArray.append("")
                    }
                    
                    if let startDate = document.data()["startDate"] as? Date{
                        self.startDateArray.append(startDate)
                    }else{
                        self.startDateArray.append(Date.init())
                    }
                    
                    self.uidArray.append(document.documentID)
                    
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
}

extension HomeViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = self.enameArray[indexPath.row]
        cell.detailTextLabel?.text = self.startDateArray[indexPath.row].description
        
        print(self.uidArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.enameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        
    }
}
