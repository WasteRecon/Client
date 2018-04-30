//
//  FirstPageViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 30/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class FirstPageViewController: UIViewController {
    
    
    //MARK: Properties
    let categoryService = CategoryServices()
    var category: Category?
    
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: Initializers
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private function
}
