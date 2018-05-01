//
//  SecondPageViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 01/05/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class SecondPageViewController: UIViewController {

    @IBOutlet weak var descLabel: UILabel!
    var myParent: CategoryPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get data from parent PageViewController
        myParent = self.parent as? CategoryPageViewController
        descLabel.text = myParent?.category?.desc
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
