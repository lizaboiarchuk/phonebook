//
//  Contact.swift
//  ContactBook
//
//  Created by user on 15.02.2021.
//

import Foundation
import UIKit

public class Contact {
    
    static var freeID: Int = 0
    var image: UIImage = UIImage()
    var defining: String = ""
    var firstName: String = ""
    var lastName: String = ""
    var company: String = ""
    var phoneNumbers: [String] = []
    var emails: [String] = []
    var birthDate: String = ""
    var notes: String = ""
    var id: Int
    var showString: NSMutableAttributedString = NSMutableAttributedString(string: "")
    
    init() {
        self.image = UIImage(systemName: "person.circle.fill") ?? UIImage()
        self.id = Contact.freeID
        Contact.freeID+=1
    }
}
