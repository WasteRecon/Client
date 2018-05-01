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
    var catName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesService.register(newObserver: self)
        loadCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cellIdentifier = "CategoriesTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CategoriesTableViewCell else {
            fatalError("CategoriesTableVC: The dequeued cell is not an instance of CategoryTableViewCell.")
        }
        
        let category = categories[indexPath.row]
        
        cell.catTitleLabel.text = category.title
        cell.catDescLabel.text = category.desc
        cell.colorImage.image = category.img
        cell.catName = category.catName
        
        return cell
    }
    
    //MARK: TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CategoriesTableViewCell else {
            fatalError("CategoriesTableVC: cant get cell")
        }
        self.catName = cell.catName
        self.performSegue(withIdentifier: "showDetailFromTable", sender: nil)
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let categoryPVC = segue.destination as? CategoryPageViewController else {
            fatalError("CategoriesTableVC: cant create categoryPVC")
        }
        categoryPVC.catName = self.catName
    }
    
    //MARK: Private func
    func loadCategories() {
        categoriesService.getAllCategories()
    }
    
    func update() {
        categories = categoriesService.categories
        self.tableView.reloadData()
    }

    
    

}
