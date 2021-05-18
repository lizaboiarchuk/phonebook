//
//  TextFieldCellModel.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import Foundation

class TextFieldCellModel: TableCell {
    var placeholder: String
    var text: String
    init(placeholder: String, text: String) {
        self.text = text
        self.placeholder = placeholder
        super.init(type: "textFieldCell")
    }
}
