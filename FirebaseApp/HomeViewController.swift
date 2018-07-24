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
import FirebaseFirestore
import MediaPlayer
import AVFoundation
import FirebaseAuth



class HomeViewController:UIViewController {
    var homeUid: String?
    
    var enameArray = [String]()
    var startDateArray = [Date]()
    var uidArray = [String]()
    var counter : Int = 0
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        
        //view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
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
        /// Volume View
//        let volumeView = MPVolumeView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
//        volumeView.isHidden = false
//        volumeView.alpha = 0.01
//        view.addSubview(volumeView)
        
        /// Notification Observer
        NotificationCenter.default.addObserver(self, selector: #selector(self.volumeDidChange(notification:)), name: NSNotification.Name(rawValue: "AVSystemController_SystemVolumeDidChangeNotification"), object: nil)

    }
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)
    }
    
 
    @objc func volumeDidChange(notification: NSNotification) {
//        print("VOLUME CHANGING", AVAudioSession.sharedInstance().outputVolume)
      
//        let volume = notification.userInfo!["AVSystemController_AudioVolumeNotificationParameter"] as! Float
        
               counter = counter + 1
         print("counter :\(counter)")
        
        
    }

}

extension HomeViewController:UITableViewDataSource, UITableViewDelegate{
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
        cell.textLabel?.text = self.enameArray[indexPath.row]
        cell.detailTextLabel?.text = self.startDateArray[indexPath.row].description
        //cell.textLabel?.textColor = UIColor.white
        //cell.detailTextLabel?.textColor = UIColor.white
        //cell.backgroundColor = UIColor(red: 31/255, green: 58/255, blue: 147/255, alpha: 1)
        
        print(self.uidArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.enameArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        tableView.deselectRow(at: indexPath, animated: true)
//        let controller = QRCodeViewController.fromStoryboard()
       
        homeUid = self.uidArray[indexPath.row]
        print("table view ", self.uidArray[indexPath.row])
//        self.navigationController?.pushViewController(controller, animated: true)
        self.performSegue(withIdentifier: "uid", sender: self)
   
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "uid"{
        let QRCodeUid = segue.destination as! QRScannerController
        QRCodeUid.currentUid = homeUid!
            print(QRCodeUid.currentUid!)
            
    }
    }
    
}
