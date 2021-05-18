//
//  Date.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import Foundation

extension Date {
    func monthAsString() -> String {
            let df = DateFormatter()
            df.setLocalizedDateFormatFromTemplate("MMM")
            return df.string(from: self)
    }
}
