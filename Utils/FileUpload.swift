//
//  FileUpload.swift
//  SearchApp
//
//  Created by dEEEP on 28/03/18.
//  Copyright © 2018 vannteqfarm. All rights reserved.
//


import Foundation
//import Alamofire
//import SVProgressHUD
import Cloudinary


class FileUpload {
  
  let queue = DispatchQueue(label: "com.fileupload.queue", attributes: DispatchQueue.Attributes.concurrent)
  var downloadedImage : UIImage?
   private let baseUrl1 = pheemeeConfig.mBaseUrl
  fileprivate let imageUrl = "posts/upload/image/"
  var countValue: Int = 0
  var cld = CLDCloudinary(configuration: CLDConfiguration(cloudName: pheemeeConfig.cloudName,apiKey: pheemeeConfig.cloudKey,apiSecret: pheemeeConfig.cloudSecret, secure: true))

  
  //Utilize Singleton pattern by instanciating API only once.
  class var sharedInstance: FileUpload {
    struct Singleton {
      static let instance = FileUpload()
    }
    
    return Singleton.instance
  }
  
  init() {
    
  }
  
   func uploadImageRemote (imageh:UIImage?, callback:@escaping (_ url:  String?, _ error: String? ) -> Void){
  if let image = imageh, let data = UIImageJPEGRepresentation(image, 1.0) {
  

  
    let progressHandler = { (progress: Progress) in
      let ratio: CGFloat = CGFloat(progress.completedUnitCount) / CGFloat(progress.totalUnitCount)
      SVProgressHUD.showProgress(Float(ratio))
    }
    cld.createUploader().upload(data: data, uploadPreset: pheemeeConfig.cloudPreset, progress: progressHandler) { (result, error) in
     SVProgressHUD.dismiss()
      
      if let error = error {
       print(error.description)
        callback(nil,"Failed")
//        os_log("Error uploading image %@", error)
      } else {
        if let result = result, let publicUrl = result.url {
          callback(publicUrl,nil)
        }else{
           callback(nil,"Failed")
        }
      }
    }
  }
  }
  
  
  //MARK:upload image to server and returns dictionary containing url and image DATA
  
  func uploadImageaaaRemote (postID:String = "",image:UIImage, callback:@escaping (_ data: Dictionary<String, String>?, _ error: NSError? ) -> Void){
    
    
//    let imageData = UIImageJPEGRepresentation(image, 1.0)
//    let imageInfo : UIImage = UIImage(data: imageData!)!
    
    let baseUrl = baseUrl1 + self.imageUrl + "/\(postID)"
    
    
     let data = UIImageJPEGRepresentation(image,1)
      

      let parameters: Parameters = [
        "x-access-token" : Constants.kUserDefaults.string(forKey: appConstants.token)!
      ]
       let imageData = UIImageJPEGRepresentation(image, 1.0)
      
      Alamofire.upload(multipartFormData: { (multipartFormData) in
        multipartFormData.append(data!, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
        for (key, value) in parameters {
          multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
        }
      }, to:baseUrl)
      { (result) in
        switch result {
        case .success(let upload, _, _):
          
          upload.uploadProgress(closure: { (Progress) in
            print("Upload Progress: \(Progress.fractionCompleted)")
          })
          
          upload.responseJSON { response in
            //self.delegate?.showSuccessAlert()
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            //                        self.showSuccesAlert()
            //self.removeImage("frame", fileExtension: "txt")
            if let JSON = response.result.value {
              print("JSON: \(JSON)")
            }
          }
          
        case .failure(let encodingError):
          //self.delegate?.showFailAlert()
          print(encodingError)
        }
        
    }}
      
    
    
    
    //MARK:upload image to server and returns dictionary containing url and image DATA
    
    func uploadVideoRemote (postID:String = "5ba4bfb8e436301a7fc38019",videoURL:NSURL, callback:@escaping (_ data: Dictionary<String, String>?, _ error: NSError? ) -> Void){
        
        
        //    let imageData = UIImageJPEGRepresentation(image, 1.0)
        //    let imageInfo : UIImage = UIImage(data: imageData!)!
        
      let baseUrl = baseUrl1 + self.imageUrl + "\(postID)"
        
      //  let data = UIImageJPEGRepresentation(image,1)
    
        
        var data: NSData?
        do {
            data = try NSData(contentsOfFile: (videoURL.relativePath)!, options: NSData.ReadingOptions.alwaysMapped)
        } catch _ {
            data = nil
            return
        }
        let parameters = [
            "x-access-token" : Constants.kUserDefaults.string(forKey: appConstants.token)! as! String
        ]
        //let imageData = UIImageJPEGRepresentation(image, 1.0)
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            multipartFormData.append(data as! Data, withName: "media", fileName: "media.mov", mimeType: "video/mov")
          
          multipartFormData.append(("video" as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: "mediaType")
            for (key, value) in parameters {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to:baseUrl,headers:parameters)
        { (result) in
            switch result {
            case .success(let upload, _, _):
              
                upload.uploadProgress(closure: { (Progress) in
                    print("Upload Progress: \(Progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    //self.delegate?.showSuccessAlert()
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                
                    //                        self.showSuccesAlert()
                    //self.removeImage("frame", fileExtension: "txt")
          
                  
                  
                  if let value = response.result.value {
                
                    if let result = value as? Dictionary<String, AnyObject> {
                      let urlModel = result[APIConstants.data.rawValue] as! [String:String]
                      callback(urlModel , nil )
                    }
                  }

                  
                }
                
            case .failure(let encodingError):
                //self.delegate?.showFailAlert()
                print(encodingError)
            }
            
        }
      
}
    }
