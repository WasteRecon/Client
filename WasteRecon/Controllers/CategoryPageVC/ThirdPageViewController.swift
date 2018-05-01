//
//  ThirdPageViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 01/05/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class ThirdPageViewController: UIViewController {

    @IBOutlet weak var factLabel: UILabel!
    var myParent: CategoryPageViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get data from parent PageViewController
        myParent = self.parent as? CategoryPageViewController
        factLabel.text = myParent?.category?.facts
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
