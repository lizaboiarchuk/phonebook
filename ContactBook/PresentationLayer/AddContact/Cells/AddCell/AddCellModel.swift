//
//  AddCellModel.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import Foundation

class AddCellModel: TableCell {
    var label: String
    var placeholder: String
    var text: String

    
    init(placeholder: String, label: String, text: String) {
        self.text = text
        self.placeholder = placeholder
        self.label = label
        super.init(type: "addCell")
    }
}
