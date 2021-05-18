//
//  IconCell.swift
//  ContactBook
//
//  Created by user on 17.02.2021.
//

import UIKit

class IconCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillCell(image: UIImage) -> UITableViewCell {

        iconView.contentMode = UIView.ContentMode.scaleAspectFill
        iconView.layer.cornerRadius = iconView.frame.width / 2
        iconView.layer.masksToBounds = true
        iconView.clipsToBounds = true
        iconView.image = image
        backgroundColor = .bgColor
        return self
    }

}
