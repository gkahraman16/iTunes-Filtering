//
//  DynamicSizedTableView.swift
//  HBCase
//
//  Created by Gozde Kahraman on 14.11.2021.
//

import Foundation
import UIKit

class DynamicSizedTableView: UITableView {
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
}
