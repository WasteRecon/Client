//
//  CategoriesTableViewCell.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class CategoriesTableViewCell: UITableViewCell {
    //MARK: Properties
    @IBOutlet weak var catTitleLabel: UILabel!
    @IBOutlet weak var colorImage: CustomImageView!
    @IBOutlet weak var cellCustom: UIView!
    
    var catName: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
