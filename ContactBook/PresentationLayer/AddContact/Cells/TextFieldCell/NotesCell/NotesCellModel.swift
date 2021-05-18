//
//  NotesCellModel.swift
//  ContactBook
//
//  Created by user on 16.02.2021.
//

import Foundation

class NotesCellModel: TableCell {
    var notes: String
    init(notes: String) {
        self.notes = notes
        super.init(type: "notesCell")
    }
}
