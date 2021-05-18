//
//  ImageCell.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import Foundation
import UIKit


class ImageCellModel: TableCell {
    var img: UIImage
    
    init(img: UIImage) {
        self.img = img
        super.init(type: "imageCell")
    }
    

}
