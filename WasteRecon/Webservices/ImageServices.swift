//
//  ImageServices.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import Foundation

class ImageServices{
    static let globalImages = ImageServices()
    
    //MARK: Properties
    var images = [Image]()
    
    //MARK: Get All Images
    func getAllImages() -> [Image]{
        return images
    }
    
    //MARK: Get image by category name
    func getImageByCatName(catName: String) -> [Image]{
        var imgByCat = [Image]()
        for image in images {
            if(catName == image.catName){
                imgByCat.append(image)
            }
        }
        
        //notifyObservers()
        return imgByCat
    }
    
    //MARK: Post new image
    func addImageToServer(newImage: Image, complete: @escaping (Bool) -> Void) {
        images.append(newImage)
        complete(true)
    }
}
