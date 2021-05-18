//
//  CellWithButton.swift
//  ContactBook
//
//  Created by user on 15.02.2021.
//

import UIKit

class CellWithButton: UITableViewCell {


    @IBOutlet weak var txtLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(text: String) -> UITableViewCell {
        txtLabel.text = text
        return self
    }

}
