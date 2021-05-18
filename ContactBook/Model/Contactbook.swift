//
//  model.swift
//  ContactBook
//
//  Created by user on 12.02.2021.
//

import Foundation
import UIKit


public let contactBook: ContactBook = ContactBook()

public class ContactBook {
    
    
    var contacts: [Int: Contact]
    var contactsByLetters: [String: [Int]]
    var sortedLetters: [String]

    
    init() {
        self.contacts = [:]
        self.contactsByLetters = [:]
        self.sortedLetters = []
        self.fillWithDefaultValues()
    }
    
    func sortLetters() {
        sortedLetters = Swift.Array(self.contactsByLetters.keys)
        sortedLetters.sort( by: {a, b in
            if b.contains("#")  {
                return true
            }
            if a.contains("#") {
                return false
            }
            return a < b
        })
    }
    
    func addContact(contact: Contact) {
        self.contacts[contact.id] = contact
        if self.contactsByLetters["\(contact.defining.first?.lowercased() ?? " ")"] != nil {
            self.contactsByLetters["\(contact.defining.first?.lowercased() ?? " ")"]?.append(contact.id)
        }
        else {
            self.contactsByLetters["\(contact.defining.first?.lowercased() ?? " ")"] = [contact.id]
        }
        if  (self.contactsByLetters["\(contact.defining.first?.lowercased() ?? " ")"]?.count ?? 0) > 1 {
            self.contactsByLetters["\(contact.defining.first?.lowercased() ?? " ")"]?.sort(by: { contacts[$0]!.defining < contacts[$1]!.defining })
        }
        if contact.defining.first?.lowercased() == "#" {
            contact.defining.remove(at: contact.defining.startIndex)
        }
        
        if contact.lastName == contact.defining {
            let normalText = "\(contact.firstName )"
            let normalString = NSMutableAttributedString(string: normalText)
            let boldText = "\(contact.lastName )"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: boldText, attributes: attrs)
            normalString.append(NSMutableAttributedString(string: " "))
            normalString.append(boldString)
            contact.showString = normalString
        }
        else if contact.firstName == contact.defining {
            let boldText = "\(contact.firstName)"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: boldText, attributes: attrs)
            contact.showString = boldString
        }
        else if contact.company == contact.defining {
            let boldText = "\(contact.company )"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: boldText, attributes: attrs)
            contact.showString = boldString
        }
        else {
            let boldText = "\(contact.defining )"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15)]
            let boldString = NSMutableAttributedString(string: boldText, attributes: attrs)
            contact.showString = boldString
        }

        sortLetters()
        
    }

    func removeContact(contact: Contact) {
        if self.contacts[contact.id] != nil {
            self.contacts[contact.id] = nil
        }
        if self.contactsByLetters["\(contact.defining.first?.lowercased() ?? " ")"] != nil {
            if self.contactsByLetters["\(contact.defining.first?.lowercased()  ?? " ")"]?.contains(contact.id) != nil {
                self.contactsByLetters["\(contact.defining.first?.lowercased()  ?? " ")"] =  self.contactsByLetters["\(contact.defining.first?.lowercased()  ?? " ")"]?.filter({ $0 != contact.id })
                if self.contactsByLetters["\(contact.defining.first?.lowercased()  ?? " ")"]?.count == 0 {
                    self.contactsByLetters["\(contact.defining.first?.lowercased()  ?? " ")"] = nil
                }
            }
        }
        sortLetters()
    }
    
    
    func fillWithDefaultValues() {
        let c1 = Contact()
 
        c1.firstName = "John"
        c1.lastName = "Appleseed"
        c1.birthDate = "February 8"
        c1.defining = c1.lastName
        self.addContact(contact: c1)
        
        let c2 = Contact()
        c2.image = UIImage(systemName: "mic") ?? UIImage()
        c2.firstName = "Anna"
        c2.lastName = "Bell"
        c2.company = "company"
        c2.phoneNumbers = ["12345", "4646123", "134544", "1454545"]
        c2.emails = ["email1", "email2"]
        c2.birthDate = "March 5"
        c2.defining = c2.lastName
        self.addContact(contact: c2)
        
        let c3 = Contact()
        c3.firstName = "David"
        c3.lastName = "Taylor"
        c3.defining = c3.lastName
        self.addContact(contact: c3)
        
        let c4 = Contact()
        c4.firstName = "Anna"
        c4.lastName = "Haro"
        c4.defining = c4.lastName
        self.addContact(contact: c4)
        
        let c5 = Contact()
        c5.firstName = "Anna"
        c5.lastName = "Anna"
        c5.defining = c5.lastName
        self.addContact(contact: c5)
        
    }
}



