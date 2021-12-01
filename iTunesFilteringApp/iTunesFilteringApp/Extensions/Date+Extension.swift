//
//  Date+Extension.swift
//  HBCase
//
//  Created by Gozde Kahraman on 12.11.2021.
//

import Foundation

extension Date {
    func dateFormatted(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
