//
//  GradientView.swift
//  SlackPrismTest
//
//  Created by Muhammad Fauzi Masykur on 3/30/18.
//  Copyright © 2018 Muhammad Fauzi Masykur. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {

    //setup the top color of the view
    @IBInspectable var topColor: UIColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    //setup the botoom color of the view
    @IBInspectable var bottomColor: UIColor = #colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    //layout the view based on the color and the coordinate of how the gradient goes
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
