//
//  ViewController2.swift
//  app1
//
//  Created by Promptnow on 8/1/2562 BE.
//  Copyright © 2562 Promptnow. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage
import FirebaseUI

class ViewController2: UIViewController {

    @IBOutlet weak var imageQR: UIImageView!
    @IBOutlet weak var textfield: UITextField!
    
    @IBOutlet weak var imageInQR: UIImageView!
    
    override func viewDidLoad() {

    }
    func downloadImage(with url: URL) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
               print(error!)
                return
            }
            DispatchQueue.main.async {
                self.imageInQR.image = UIImage(data: data!)
            }
        }.resume()
    }
    
    @IBAction func bt(_ sender: Any) {
//        if let myString = textfield.text {
//            let data = myString.data(using: .ascii, allowLossyConversion: false)
//            let filter = CIFilter(name: "CIQRCodeGenerator")
//            filter?.setValue(data, forKey: "inputMessage")
//            filter?.setValue("H", forKey: "inputCorrectionLevel")
//
//            guard let qrcode = filter?.outputImage else { return }
//            let scaleX = imageQR.frame.size.width / qrcode.extent.size.width
//            let scaleY = imageQR.frame.size.height / qrcode.extent.size.height
//
//            let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
//
//            let output = filter?.outputImage?.transformed(by: transform)
//
//            let img = UIImage(ciImage: (output)! )
//
//            imageQR.image = img
//        }
        


        
        if textfield.text != "" {
            guard let datadb = textfield.text else {return}
            let docRef = Firestore.firestore().collection("Promptnow").document(datadb)
            
            let imageName = NSUUID().uuidString
            var myImageView = UIImageView()

            
            docRef.getDocument{ (document, err) in
                if let document = document {
                    if document.exists{
                     //   let dbRef = Storage.storage().reference().child("image.png")

                   //     self.downloadImage(with: self.imageurll!)

//                        let myData = document.data()
//                        if let profileURL = myData?["imageURL"] as? String {
//                            let storageRef = Storage.storage().reference(forURL: profileURL)
//                            let imageurll = URL(string: profileURL)
//
//                            self.downloadImage(with: imageurll!)
//
//                            //   myImageView?.sd_setImage(with: storageRef, placeholderImage: UIImage(named: "image.png"))
//                         //   self.imageInQR.image = storageRef as? UIImage
//                           print(storageRef)
//                        }
//                        else {
//                            print("profileURL is nil")
//                        }
                        
                        
                        let imageurl = document.get("imageURL") as! String
                        let imageurl2 = URL(string: imageurl)
                        self.downloadImage(with: imageurl2!)

                        let age = document.get("age") as! String
                        let name = document.get("name") as! String
                        let docID = document.documentID
                    
                        
                        var data = name.data(using: .ascii, allowLossyConversion: false)
                        
                        let filter = CIFilter(name: "CIQRCodeGenerator")
                        filter?.setValue(data, forKey: "inputMessage")
                        filter?.setValue("M", forKey: "inputCorrectionLevel")
                        guard let qrcode = filter?.outputImage else { return }
                        let scaleX = self.imageQR.frame.size.width / qrcode.extent.size.width
                        let scaleY = self.imageQR.frame.size.height / qrcode.extent.size.height
                        
                        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                        
                        let output = filter?.outputImage?.transformed(by: transform)
                        
                        let img = UIImage(ciImage: (output)! )
                        
                        self.imageQR.image = img

                    }else {
                        let alert = UIAlertController(title: "ไม่พบข้อมูลในการสร้าง", message: nil, preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert.addAction(okButton)
                        self.present(alert,animated: true,completion: nil)
                        
                    }
                    
                }
                
            }
            // end
//            func downloadimage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
//                let data = URLSession.shared.dataTask(with: url) { data, url, error in
//                    var downloadtimage:UIImage?
//
//                    if let data = data {
//                        downloadtimage = UIImage(data: data)
//                    }
//                    DispatchQueue.main.async {
//                         completion(downloadtimage)
//
//                    }
//                }
//                data.resume()
//
//            }
        }
    }
}
