//
//  emptyCell.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import UIKit

class EmptyCell: UITableViewCell {

    @IBOutlet weak var emptyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell() -> UITableViewCell {
        emptyLabel.backgroundColor = .bgColor
        return self
    }

}
