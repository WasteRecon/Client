//
//  ItemServices.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import Foundation

class ItemServices: Observable{
    //MARK: Properties
    private var apiUrl: String = "http://localhost:41860/iOSDev/webresources"
    var observers = [Observer]()
    var catName: String?
    
    //MARK: POST
    func getCatNameByItem(newItem: Item, complete: @escaping (Bool) -> Void){
        guard let url = URL(string: (apiUrl + "/items")) else{
            fatalError("Failed to create URL: Post Item")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("text/plain", forHTTPHeaderField: "Accept")
        
        let jsonContent = ["shape": newItem.shape, "material": newItem.material]
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
                self.catName = dataString
            }
            complete(true)
        }
        task.resume()
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
