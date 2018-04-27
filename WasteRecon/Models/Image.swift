//
//  Image.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class Image {
    //MARk: Properties
    var name: String
    var img: UIImage
    var catName: String
    
    //MARK: Initializer
    init(catName: String, img: UIImage){
        self.catName = catName
        
        //Set current timestamp as name
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
        let result = formatter.string(from: date)
        
        self.name = result
        self.img = img
    }
    
    init(catName: String, imgInBase64: String, name: String){
        self.catName = catName
        self.name = name
        self.img = Image.convertBase64ToImage(imgString: imgInBase64)
    }
    
    //MARK: Private Methods
    //Convert String to Base64
    static func convertImageToBase64(img: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(img)
        guard let base64String = imgData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: NSData.Base64EncodingOptions.RawValue(0))) else{
            fatalError("Unable to encode")
        }
        return base64String
    }
    
    //Convert Base64 to String
    static func convertBase64ToImage(imgString: String) -> UIImage {
        let imgData = Data(base64Encoded: imgString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imgData)!
    }
}
