//
//  PhotoCellViewController.swift
//  FirebaseApp
//
//  Created by james on 15/7/18.
//  Copyright © 2018年 Robert Canton. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "Cell"

class PhotoViewController: UICollectionViewController {
    var urlName:String?
    var fireUploadDic: [String:Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let databaseRef = Database.database().reference().child(urlName!)
        
        databaseRef.observe(.value, with: { [weak self] (snapshot) in
            
            if let uploadDataDic = snapshot.value as? [String:Any] {
                
                self?.fireUploadDic = uploadDataDic
                self?.collectionView!.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        if let dataDic = fireUploadDic {
            
            return dataDic.count
        }
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoViewCell
        
        // Configure the cell
        if let dataDic = fireUploadDic {
            let keyArray = Array(dataDic.keys)
            if let imageUrlString = dataDic[keyArray[indexPath.row]] as? String {
                if let imageUrl = URL(string: imageUrlString) {
                    
                    URLSession.shared.dataTask(with: imageUrl, completionHandler: { (data, response, error) in
                        
                        if error != nil {
                            
                            print("Download Image Task Fail: \(error!.localizedDescription)")
                        }
                        else if let imageData = data {
                            
                            DispatchQueue.main.async {
                                
                                cell.fireImageView.image = UIImage(data: imageData)
                            }
                        }
                        
                    }).resume()
                }
            }
        }
        return cell
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
