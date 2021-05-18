//
//  addCell.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import UIKit

class AddCell: UITableViewCell {

    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(placeholder: String, label: String, text: String) -> UITableViewCell { 
        textField.text = text
        textField.placeholder = placeholder
        self.label.text = label
        return self
        
        
    }

}
