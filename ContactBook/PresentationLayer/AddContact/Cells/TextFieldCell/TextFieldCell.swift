//
//  FirstTableViewCell.swift
//  ContactBook
//
//  Created by user on 15.02.2021.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell (placeholder: String, text: String) -> UITableViewCell {
        textField.text = text
        textField.placeholder = placeholder
        return self
    }
    
  

}
