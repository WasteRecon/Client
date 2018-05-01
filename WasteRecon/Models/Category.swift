//
//  Category.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class Category{
    //MARK: Properties
    var catName: String
    var title: String
    var desc: String
    var facts: String
    var img: UIImage
    
    //MARK: Initializer
    init(catName: String, title: String, desc: String, facts: String, imgInBase64: String){
        self.catName = catName
        self.desc = desc
        self.facts = facts
        self.title = title
        
        self.img = Category.convertBase64ToImage(imgString: imgInBase64)
    }
    
    //MARK: Private methods
    //Convert String to Base64
    static func convertImageToBase64(img: UIImage) -> String {
        let imgData = UIImagePNGRepresentation(img)
        guard let base64String = imgData?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: NSData.Base64EncodingOptions.RawValue(0))) else{
            fatalError("Category model: Unable to encode")
        }
        return base64String
    }
    
    //Convert Base64 to String
    static func convertBase64ToImage(imgString: String) -> UIImage {
        let imgData = Data(base64Encoded: imgString, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
        return UIImage(data: imgData)!
    }
}
