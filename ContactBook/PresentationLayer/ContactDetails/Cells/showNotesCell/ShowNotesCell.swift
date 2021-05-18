//
//  ShowNotesCell.swift
//  ContactBook
//
//  Created by user on 17.02.2021.
//

import UIKit

class ShowNotesCell: UITableViewCell {

    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    

    func fillCell(note: String) -> UITableViewCell {
        bringSubviewToFront(notesLabel)
//        notesLabel.backgroundColor = .white
//        noteTextView.textContainerInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        noteTextView.text = note
        noteTextView.isEditable = false
//        contentView.layer.cornerRadius = 20
//        contentView.layer.masksToBounds = true
        return self
    }
}
