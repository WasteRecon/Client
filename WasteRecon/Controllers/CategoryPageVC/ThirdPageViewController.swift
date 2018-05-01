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
        myParent = self.parent as! CategoryPageViewController
        
        factLabel.text = myParent?.category?.facts
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

}
