//
//  ImageCell.swift
//  ContactBook
//
//  Created by user on 15.02.2021.
//

import UIKit

class ImageCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(image: UIImage) -> UITableViewCell {
        img.contentMode = UIView.ContentMode.scaleAspectFill
        img.layer.cornerRadius = img.frame.width / 2
        img.layer.masksToBounds = true
        img.clipsToBounds = true
        img.image = image
        backgroundColor = .bgColor
        return self
    }

    
}


