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
    }
}
