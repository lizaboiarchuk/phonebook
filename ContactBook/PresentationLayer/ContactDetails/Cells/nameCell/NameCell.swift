//
//  NameCell.swift
//  ContactBook
//
//  Created by user on 17.02.2021.
//

import UIKit

class NameCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillCell(name: String, company: String  ) -> UITableViewCell {
        backgroundColor = .bgColor
        nameLabel.text = name
        companyLabel.text = company
        return self
    }
}
