//
//  CustomView.swift
//  HBCase
//
//  Created by Gozde Kahraman on 14.11.2021.
//

import Foundation
import UIKit

protocol CustomView {
    var nibName: String { get }
    func attachView()
}

extension CustomView where Self: UIView {
    var nibName: String {
        return String(describing: type(of: self))
    }
    
    func attachView() {
        let nib =  UINib(nibName: nibName, bundle: nil)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView ?? UIView(frame: .zero)
        
        addSubview(view)
        view.backgroundColor = .clear
        view.frame = bounds
    }
}
