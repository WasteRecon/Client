//
//  CategoriesTableViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController, Observer {
    //MARK: Properties
    let categoriesService = CategoryServices()
    var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesService.register(newObserver: self)
        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "CategoriesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoriesTableViewCell else {
            fatalError("The dequeued cell is not an instance of CategoryTableViewCell.")
        }
        
        let category = categories[indexPath.row]
        
        cell.catNameLabel.text = category.title
        cell.catDescLabel.text = category.desc
        cell.colorImage.image = category.img
        
        
        return cell
    }
    
    func loadCategories() {
        categoriesService.getAllCategories()
    }
    
    func update() {
        categories = categoriesService.categories
        self.tableView.reloadData()
    }

    
    

}
