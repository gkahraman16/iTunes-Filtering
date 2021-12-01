//
//  UIView+Extension.swift
//  HBCase
//
//  Created by Gozde Kahraman on 12.11.2021.
//

import Foundation
import UIKit

extension UIView {
    func applyShadowCardViewStyle(){
        self.layer.cornerRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.3
    }
}
