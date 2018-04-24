//
//  Item.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 24/04/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import Foundation

class Item{
    //MARK: Properties
    var shape: String
    var material: String
    
    //MARK: Initializer
    init(shape: String, material: String){
        self.material = material
        self.shape = shape
    }
}
