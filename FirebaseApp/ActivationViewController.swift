//
//  ActivationViewController.swift
//  FirebaseApp
//
//  Created by hok lam wong on 22/7/2018.
//  Copyright © 2018 Robert Canton. All rights reserved.
//
import Firebase
import FirebaseFirestore

import FirebaseStorage
import FirebaseDatabase

import UIKit

class ActivationViewController: UIViewController {
    @IBOutlet weak var userPhoto: UIImageView!
    var currentUID: String?
    var currentSelectItem: String?
    var urlName: String?
    var uploadedPhoto: Bool = false
    @IBOutlet weak var activateBtn: RoundedWhiteButton!
    @IBOutlet weak var uploadPhotoBtn: RoundedWhiteButton!
    let db = Firestore.firestore()
    var continueButton:RoundedWhiteButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userPhoto.layer.cornerRadius = userPhoto.frame.size.width/2
        activateBtn.layer.cornerRadius = 20
            userPhoto.clipsToBounds = true
        uploadPhotoBtn.layer.cornerRadius = 20
        if (uploadedPhoto == false){
            activateBtn.alpha = 0.5
            activateBtn.isEnabled = false
        }
        else
        {
            activateBtn.alpha = 1.0
            activateBtn.isEnabled = true
        }

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func uploadPhotoBtn(_ sender: UIButton) {
        
        // 建立一個 UIImagePickerController 的實體
        let imagePickerController = UIImagePickerController()
        
        // 委任代理
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        // 建立一個 UIAlertController 的實體
        // 設定 UIAlertController 的標題與樣式為 動作清單 (actionSheet)
        let imagePickerAlertController = UIAlertController(title: "上傳圖片", message: "請選擇要上傳的圖片", preferredStyle: .actionSheet)
        
        // 建立三個 UIAlertAction 的實體
        // 新增 UIAlertAction 在 UIAlertController actionSheet 的 動作 (action) 與標題
//        let imageFromLibAction = UIAlertAction(title: "照片圖庫", style: .default) { (Void) in
//
//            // 判斷是否可以從照片圖庫取得照片來源
//            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
//
//                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.photoLibrary)，並 present UIImagePickerController
//                imagePickerController.sourceType = .photoLibrary
//                self.present(imagePickerController, animated: true, completion: nil)
//            }
//        }
        let imageFromCameraAction = UIAlertAction(title: "相機", style: .default) { (Void) in
            
            // 判斷是否可以從相機取得照片來源
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                // 如果可以，指定 UIImagePickerController 的照片來源為 照片圖庫 (.camera)，並 present UIImagePickerController
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }
        }
        
        // 新增一個取消動作，讓使用者可以跳出 UIAlertController
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (Void) in
            
            imagePickerAlertController.dismiss(animated: true, completion: nil)
        }
        
        // 將上面三個 UIAlertAction 動作加入 UIAlertController
//        imagePickerAlertController.addAction(imageFromLibAction)
        imagePickerAlertController.addAction(imageFromCameraAction)
        imagePickerAlertController.addAction(cancelAction)
       
   
        
        // 當使用者按下 uploadBtnAction 時會 present 剛剛建立好的三個 UIAlertAction 動作與
        present(imagePickerAlertController, animated: true, completion: nil)
           self.uploadedPhoto = true
        if (uploadedPhoto == false){
            activateBtn.alpha = 0.5
            activateBtn.isEnabled = false
        }
        else
        {
            activateBtn.alpha = 1.0
            activateBtn.isEnabled = true
        }
    }
    
    
    @IBAction func activateBtn(_ sender: UIButton) {
        let docData: [String: Any] = [
            "activate": true,
            ]
        db.collection("competition").document(currentUID!).collection("participant").document(currentSelectItem!).updateData(docData)
        
        let alertController = UIAlertController(title: "Successful!",
                                                message: nil, preferredStyle: .alert)
    
        self.performSegue(withIdentifier: "toPersonalVC", sender: self)
        self.present(alertController, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.presentedViewController?.dismiss(animated: false, completion: nil)
        }
      


    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
      
        if segue.identifier == "toPersonalVC"{
            let user = segue.destination as! personalInformViewController
           user.userPhoto  = self.userPhoto
            user.currentUID = self.currentUID
            user.urlName = self.urlName

        }
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



extension ActivationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
            self.userPhoto.image = resizeImage(image: pickedImage)
            self.userPhoto.layer.cornerRadius = userPhoto.frame.size.width/2
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
