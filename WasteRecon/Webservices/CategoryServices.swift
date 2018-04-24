//
//  CategoryServices.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import Foundation

class CategoryServices: Observable {
    //MARK: Properties
    private var apiUrl: String = "http://localhost:41860/iOSDev/webresources"
    var observers = [Observer]()
    var categories = [Category]()
    
    //MARK: Get all
    func getAllCategories() {
        guard let url = URL(string: (apiUrl + "/categories")) else {
            fatalError("Failed to create GET All Categores url")
        }
        
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print("Client error: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: Failed to GET all categories")
                return
            }
            
            if let data = data {
                self.parseCategory(jsonFile: data)
                DispatchQueue.main.async{
                    self.notifyObservers()
                }
            }
        }
        
        task.resume()
    }
    
    //MARK: Get category by catName
    func getCategoryByName(catName: String){
        guard let url = URL(string: (apiUrl + "/categories/" + catName)) else {
            fatalError("Failed to create GET category by Name URL error")
        }
        
        let task = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print("Client error: \(error)")
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Server error: Failed to GET category by name")
                return
            }
            
            if let data = data {
                self.parseCategory(jsonFile: data)
                DispatchQueue.main.async{
                    self.notifyObservers()
                }
            }
        }
        
        task.resume()
    }
    
    //MARK: JSON Parsing
    func parseCategory(jsonFile: Data){
        guard let json = try? JSONSerialization.jsonObject(with: jsonFile, options: []) as! [[String:Any]] else {
            fatalError("Failed to parse Category JSON")
        }
        
        if !json.isEmpty{
            categories.removeAll()
            for category in json {
                guard let catName = category["catName"] as? String, let title = category["title"] as? String else {
                    fatalError("Parse error: catName and title")
                }
                
                guard let desc = category["desc"] as? String, let facts = category["facts"] as? String else {
                    fatalError("Parse error: desc and facts")
                }
                
                guard let img = category["img"] as? String else{
                    fatalError("Parse error: img")
                }
                
                let newCategory = Category(catName: catName, title: title, desc: desc, facts: facts, imgInBase64: img)
                self.categories.append(newCategory)
            }
        }
    }
    
    //MARK: Observer func
    func register(newObserver: Observer) {
        if observers.index(where: {($0 as AnyObject) === (newObserver as AnyObject)}) == nil {
            observers.append(newObserver)
        }
    }
    
    func unregister(oldObserver: Observer){
        if let index = observers.index(where: {($0 as AnyObject) === (oldObserver as AnyObject)}) {
            observers.remove(at: index)
        }
    }
    
    func notifyObservers() {
        for observer in observers{
            observer.update()
        }
    }
}
