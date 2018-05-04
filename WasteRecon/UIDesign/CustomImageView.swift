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
        self.clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = self.frame.height / radius
    }
    
    func fadeEdge(imageView: CustomImageView) -> CAGradientLayer{
        let maskLayer = CAGradientLayer()
        maskLayer.frame = imageView.bounds
        maskLayer.shadowRadius = 10
        maskLayer.shadowPath = CGPath(roundedRect: imageView.bounds.insetBy(dx: 5, dy: 5), cornerWidth: 10, cornerHeight: 10, transform: nil)
        maskLayer.shadowOpacity = 2;
        maskLayer.shadowOffset = CGSize.zero
        maskLayer.shadowColor = UIColor.white.cgColor
        return maskLayer
    }
}
