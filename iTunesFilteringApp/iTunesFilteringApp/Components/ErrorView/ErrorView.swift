//
//  ErrorView.swift
//  HBCase
//
//  Created by Gozde Kahraman on 14.11.2021.
//

import Foundation
import UIKit

class ErrorView: UIView, CustomView {
    
    @IBOutlet var iconImage: UIImageView!
    @IBOutlet var errorMessage: UILabel!
    
    @IBInspectable var errorStyle: Int = ErrorStyle.noResult.rawValue {
        didSet { refresh() }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    func initView() {
        attachView()
        backgroundColor = .none
        refresh()
    }
    
    func refresh() {
        switch errorStyle {
        case ErrorStyle.noResult.rawValue:
            iconImage.image = UIImage(systemName: "exclamationmark.circle")
            iconImage.tintColor = UIColor(red: 230/255, green: 220/255, blue: 243/255, alpha: 1)
            errorMessage.text = "No results"
        case ErrorStyle.error.rawValue:
            iconImage.image = UIImage(systemName: "exclamationmark.circle")
            iconImage.tintColor = .lightGray
            errorMessage.text = "Something went wrong..."
        case ErrorStyle.info.rawValue:
            iconImage.image = UIImage(systemName: "info.circle")
            iconImage.tintColor = UIColor(red: 236/255, green: 120/255, blue: 48/255, alpha: 1)
            errorMessage.text = "info"
        default:
            iconImage.image = UIImage(systemName: "exclamationmark.circle")
            iconImage.tintColor = UIColor(red: 230/255, green: 220/255, blue: 243/255, alpha: 1)
            errorMessage.text = "No results"
        }
    }
    
    func setMessage(text: String) {
        errorMessage.text = text
    }
    
    
}

enum ErrorStyle: Int {
    case noResult = 0
    case error = 1
    case info = 2
    
}
