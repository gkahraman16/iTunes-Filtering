//
//  StringExtension.swift
//  HBCase
//
//  Created by Gozde Kahraman on 12.11.2021.
//

import Foundation

extension Double {
    var priceFormatted: String {
        return self > 0 ? "$ \(self)" : "Free"
    }
}
