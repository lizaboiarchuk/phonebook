//
//  CellWithButtonModel.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import Foundation


class CellWithButtonModel: TableCell {
    
    var text: String

    
    init(text: String) {
        self.text = text
        super.init(type: "cellWithButton")
    }
    
    
}
