//
//  ImageServices.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import Foundation

class ImageServices: Observable {
    //MARK: Properties
    private var apiUrl: String = "http://localhost:41860/iOSDev/webresources"
    var observers = [Observer]()
    var images = [Image]()
    
    //MARK: Get All Images
    func getAllImages(){
        guard let url = URL(string: (apiUrl + "/images")) else {
            fatalError("Failed to create URL: getAllImages")
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Client error: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Server error: getAllImages")
                    return
            }
            
            if let data = data {
                self.parseImageFromJson(jsonFile: data)
                DispatchQueue.main.async {
                    self.notifyObservers()
                }
            }
        }
        task.resume()
    }
    
    //MARK: Get image by category name
    func getImageByCatName(catName: String){
        guard let url = URL(string: (apiUrl + "/images/" + catName)) else{
            fatalError("Failed to create get image by catName URL error")
        }
        
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print("Client error: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: Failed to get image by catName")
                return
            }
            
            if let data = data {
                self.parseImageFromJson(jsonFile: data)
                DispatchQueue.main.async{
                    self.notifyObservers()
                }
            }
        }
        
        task.resume()
    }
    
    //MARK: Post new image
    func addImageToServer(newImage : Image, complete: @escaping (Bool) -> Void) {
        guard let url = URL(string: (apiUrl + "/images")) else {
            fatalError("Failed to create URL: Post image")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("text/plain", forHTTPHeaderField: "Accept")
        
        let jsonContent = ["name": newImage.name , "img": Image.convertImageToBase64(img: newImage.img), "catName": newImage.catName]
        try? request.httpBody = JSONSerialization.data(withJSONObject: jsonContent, options: JSONSerialization.WritingOptions(rawValue: 0))
        
        guard let uploadData = try? JSONEncoder().encode(jsonContent) else {
            fatalError("Cannot create upload data: Post image")
        }
        
        let task = URLSession.shared.uploadTask(with: request, from: uploadData) { data, response, error in
            if let error = error {
                print ("Client error: \(error)")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                    print ("Server error response post")
                    return
            }
            if let mimeType = response.mimeType,
                mimeType == "text/plain",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print ("Server response: \(dataString)")
            }
            complete(true)
        }
        task.resume()
        
    }
    
    //MARK: Parse Json
    func parseImageFromJson(jsonFile: Data){
        guard let json = try? JSONSerialization.jsonObject(with: jsonFile, options: []) as! [[String:Any]] else {
            fatalError("Failed to parse json: Image")
        }
        
        if !json.isEmpty{
            images.removeAll()
            for image in json {
                guard let name = image["name"] as? String, let img = image["img"] as? String, let catName = image["catName"] as? String else{
                    fatalError("Json error: name, img, catName")
                }
                
                guard let newImage = Image(catName: catName, imgInBase64: img, name: name) else{
                    fatalError("Failed to initialize newImage")
                }
                self.images.append(newImage)
            }
        }
    }
    
    //MARK: Observer
    func register(newObserver: Observer) {
        if observers.index(where: {($0 as AnyObject) === (newObserver as AnyObject)}) == nil {
            observers.append(newObserver)
        }
    }
    
    func unregister(oldObserver: Observer) {
        if let index = observers.index(where: {($0 as AnyObject) === (oldObserver as AnyObject)}) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        for observer in observers {
            observer.update()
        }
    }
}
