//
//  CustomImageView.swift
//  WasteRecon
//
//  Created by Tran Cong Thanh on 03/05/2018.
//  Copyright © 2018 WasteRecon. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    override func awakeFromNib() {
        
    }
    
    func setImageAndShadow(image: UIImage, myView : UIView, radius: CGFloat) {
        self.image = image
        self.superview?.layoutIfNeeded()
        print("Image size \(self.frame.size)")
        self.clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height / radius
        
        /*let Shape = CAShapeLayer()
        let myPath = UIBezierPath(ovalIn: self.frame)
        
        Shape.shadowPath = myPath.cgPath
        Shape.shadowColor = UIColor.black.cgColor
        Shape.shadowOffset = CGSize(width: 0, height: 3)
        Shape.shadowRadius  = 7
        Shape.shadowOpacity = 0.7*/
        
        
        //myView.layer.insertSublayer(Shape, at: 0)
        
    }
}
