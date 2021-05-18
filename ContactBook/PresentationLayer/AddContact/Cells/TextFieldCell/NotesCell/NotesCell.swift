//
//  NotesCell.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import UIKit

class NotesCell: UITableViewCell {


    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func fillCell(note: String) -> UITableViewCell {
        noteTextView.text = note
        label.layer.borderWidth = 0
        return self
    }

}
