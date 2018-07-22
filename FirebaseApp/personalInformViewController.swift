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

import FirebaseStorage
import FirebaseDatabase

class personalInformViewController: UIViewController {

    
    
    @IBOutlet weak var ID: UILabel!
    @IBOutlet weak var EName: UILabel!
    @IBOutlet weak var CName: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var schoolName: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var urlName:String?
    var currentUID: String?
    var userCompetition = [String]()
    var counterArray = [String]()
    let db = Firestore.firestore()
    var currentItemType: String = ""

    override func viewDidLoad() {
        
        
        super.viewDidLoad()

         //print("Personal UID:" , currentUID!)
        struct compItem {
            let title: String
            let name: [String]
            
            init(title: String, name: [String]){
                self.title = title
                self.name = name
            }
        }
        db.collection("competition").document(currentUID!).collection("participant").document(urlName!).addSnapshotListener { documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            if let id = document.data()!["ID"] as? String{
                self.ID.text = "\(id)"
            }
            if let Ename = document.data()!["EName"] as? String{
                self.EName.text = "\(Ename)"
            }
            if let Cname = document.data()!["CName"] as? String{
                self.CName.text = "\(Cname)"
                print( "Chinese Name:" , self.CName.text!)
            }
            if let Bdate = document.data()!["BDate"] as? Date{

                //let formatter = DateFormatter()
                //Bdate.dateFormat = "yyyy-MM-dd HH:mm:ss"
                
//                let a = Bdate.string(from: Date())
//                let b = Bdate.date(from: a)
//                Bdate.dateFormat = "dd-MM-yyyy"
//                let lastDate = Bdate.string(from: myDate!)
//                let date = formatGet.string(from: Bdate)
//                let bdate = formatPrint.date(from: date)
                self.birthDate.text = "\(Bdate)"
            }
            if let SchoolName = document.data()!["schoolName"]{
                self.schoolName.text = "\(SchoolName)"
            }
            if let compItem = document.data()!["user_CompetitionItem"] as? compItem{
                print( "Array:    ===>" , compItem)
            }
            self.userCompetition = document.data()!["user_CompetitionItem"] as! [String]
           
             self.counterArray.append(document.documentID)
            
            self.tableView.reloadData()
        }
     
        // Do any additional setup after loading the view.
    }
//    func queryInUserCompetition() {
//        // [START query_in_category]
//      db.collection("competition")
//            .whereField((UID.text!+".userCompetitionItem"), isEqualTo: true)
//            .getDocuments() { (querySnapshot, err) in
//                self.userCompetition.append("")
//                print(self.userCompetition)
//
//        }
        // [END query_in_category]
//    }

    @IBAction func uploadBtnAction(_ sender: UIButton) {
        
        // 建立一個 UIImagePickerController 的實體
        let imagePickerController = UIImagePickerController()
        
        // 委任代理
        imagePickerController.delegate = self
        
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "Uplaod Photo", message: "", preferredStyle: .actionSheet)
        
        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
        let imageFromLibAction = UIAlertAction(title: "Photos", style: .default) { (Void) in
            
            // 判斷是否可以從照片圖庫取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        let imageFromCameraAction = UIAlertAction(title: "Camera", style: .default) { (Void) in
            
            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        // 將上面三個 UIAlertAction 動作加入 UIAlertController
        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true, completion: nil)
    }
    
    fileprivate func getCurrentItemType(_ indexPath: IndexPath) {
        let currentSelectItem: String =  self.userCompetition[indexPath.row]
        
        //        print("Selected ltem = ", currentSelectItem)
        
        db.collection("competition").document(currentUID!).collection("competitionItem").document(currentSelectItem).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            self.currentItemType = document.data()!["areaType"] as! String
            print("currentItemType : ",self.currentItemType)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   
        if segue.identifier == "photo"{
            let mark = segue.destination as! PhotoViewController
            mark.urlName = self.urlName
        }
        if segue.identifier == "fancy"{
            let fancy = segue.destination as! Mark4ViewController
            fancy.currentUID = self.currentUID
            fancy.currentSelectItem = self.currentItemType
            fancy.urlName = self.urlName
        }
        if segue.identifier == "speed"{
            let speed = segue.destination as! MarkViewController
            speed.currentUID = self.currentUID
            speed.currentSelectItem = self.currentItemType
            speed.urlName = self.urlName
        }
       
    }
    
    
    
    @IBAction func photo(_ sender: UIButton){
        self.performSegue(withIdentifier: "photo", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

extension personalInformViewController:UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) 
           cell.textLabel?.text = self.userCompetition[indexPath.row]

        print("personal view ", self.userCompetition[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userCompetition.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        var currentItemType_TableView : String?
        let currentSelectItem: String =  self.userCompetition[indexPath.row]
        
        //        print("Selected ltem = ", currentSelectItem)
        
        db.collection("competition").document(currentUID!).collection("competitionItem").document(currentSelectItem).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            currentItemType_TableView = document.data()!["areaType"] as? String
            print("currentItemType_TableView in db : ",currentItemType_TableView!)
            if (currentItemType_TableView == "speed"){
                self.currentItemType = currentSelectItem
                self.performSegue(withIdentifier: "speed", sender: self)
            }
            else{
                self.currentItemType = currentSelectItem
                self.performSegue(withIdentifier: "fancy", sender: self)
            }
        }
        
       
       
        
        
    }
    
}

extension personalInformViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func resizeImage(image: UIImage) -> UIImage {
        
        UIGraphicsBeginImageContext(CGSize(width: 408, height: 544))
        image.draw(in: CGRect(x: 0, y: 0, width: 408, height: 544))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
     
        
        // 取得從 UIImagePickerController 選擇的檔案
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selectedImageFromPicker = resizeImage(image: pickedImage)
        }
        
        // 可以自動產生一組獨一無二的 ID 號碼，方便等一下上傳圖片的命名
        let uniqueString = NSUUID().uuidString
        
        // 當判斷有 selectedImage 時，我們會在 if 判斷式裡將圖片上傳
        if let selectedImage = selectedImageFromPicker {
            
            let storageRef = Storage.storage().reference().child(urlName!).child("\(uniqueString).png")
            
            if let uploadData = UIImagePNGRepresentation(selectedImage) {
                // 這行就是 FirebaseStorage 關鍵的存取方法。
                storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        
                        // 若有接收到錯誤，我們就直接印在 Console 就好，在這邊就不另外做處理。
                        print("Error: \(error!.localizedDescription)")
                        return
                    }
                    
                    storageRef.downloadURL(completion: { (url, error) in
                        if error != nil{
                            print("error")
                            return
                        }
                        if let uploadImageUrl = url?.absoluteString {
                            
                            // 我們可以 print 出來看看這個連結事不是我們剛剛所上傳的照片。
                            print("Photo Url: \(uploadImageUrl)")
                            
                            let databaseRef = Database.database().reference().child(self.urlName!).child(uniqueString)
                            
                            databaseRef.setValue(uploadImageUrl, withCompletionBlock: { (error, dataRef) in
                                
                                if error != nil {
                                    
                                    print("Database Error: \(error!.localizedDescription)")
                                }
                                else {
                                    
                                    print("圖片已儲存")
                                }
                                
                            })
                        }
                        
                    })
                    // 連結取得方式就是：data?.downloadURL()?.absoluteString。
                    
                    
                })
            }
        }
        
        dismiss(animated: true, completion: nil)
    }
}


