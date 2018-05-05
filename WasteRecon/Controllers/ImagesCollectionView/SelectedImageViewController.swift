//
//  SelectedImageViewController.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 04/05/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class SelectedImageViewController: UIViewController {
    //MARK: Properties
    var selectedImage: Image?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var catNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = selectedImage?.img
        nameLabel.text = "\(selectedImage!.name)"
        catNameLabel.text = "\(selectedImage!.catName.uppercased())"
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
