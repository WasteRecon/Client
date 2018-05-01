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
    @IBOutlet weak var catDescLabel: UILabel!
    @IBOutlet weak var colorImage: UIImageView!
    var catName: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
