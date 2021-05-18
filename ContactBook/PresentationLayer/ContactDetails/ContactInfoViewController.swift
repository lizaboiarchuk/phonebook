//
//  ContactInfoViewController.swift
//  ContactBook
//
//  Created by user on 12.02.2021.
//

import UIKit

public class ContactInfoViewController: UIViewController {
    
    // MARK: Cells order
    var fields: [String] = []
    
    
    // MARK: Variables
    var currentContact = Contact()
    
    
    // MARK: UI Elements
    @IBOutlet weak var detailsTable: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    // MARK: LAYOUT CONSTANTS
    var phoneNumberLabelHeight = 60
    var emailLabelHeight = 60
    var birtdayLabelHeight = 60
    
    
    
    // MARK: Application Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgColor
        
        navBar.shadowImage = UIImage()
        navBar.barTintColor = .bgColor
        
        detailsTable.backgroundColor = .bgColor
        detailsTable.delegate = self
        detailsTable.dataSource = self
        detailsTable.separatorStyle = .none
        defineFields()
    }
    
    
    func defineFields() {
        fields = []
        fields.append("image")
        fields.append("name")
        if currentContact.phoneNumbers.count != 0 {
            fields.append("phones")
        }
        if currentContact.emails.count != 0 {
            fields.append("emails")
        }
        if currentContact.birthDate != "" {
            fields.append("birthday")
        }
        fields.append("notes")
        fields.append("empty")
    }
    

 
    // MARK: Navigation to other screens
    @IBAction func backToContacts(_ sender: Any) {
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToEditScreen" {
            let editVC = segue.destination as? AddContactViewController ??
                AddContactViewController()
            editVC.modalPresentationStyle = .fullScreen
            editVC.sendedContact = currentContact
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.view.window!.layer.add(transition, forKey: nil)
        }
    }
}









// MARK: Table Data Source Methods
extension ContactInfoViewController: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        fields.count
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    // configuring height
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if fields[indexPath.section] == "phones" {
            return CGFloat(currentContact.phoneNumbers.count * phoneNumberLabelHeight)
        }
        if fields[indexPath.section] == "emails" {
            return CGFloat(currentContact.emails.count * emailLabelHeight)
        }
        if fields[indexPath.section] == "birthday" {
            return CGFloat(birtdayLabelHeight)
        }
        return UITableView.automaticDimension
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let field = fields[indexPath.section]
        
        switch field {
        
        case "image":
            let cell = tableView.dequeueReusableCell(withIdentifier: "iconCell",for: indexPath) as? IconCell ?? IconCell()
            return cell.fillCell(image: currentContact.image)
            
        case "name":
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? NameCell ?? NameCell()
            var name = "\(currentContact.defining)"
            if currentContact.firstName != "" && currentContact.lastName != "" {
                name = "\(currentContact.firstName) \(currentContact.defining)"
            }
            return cell.fillCell(name: name, company: "\(currentContact.company)")
            
        case "notes":
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as? ShowNotesCell ?? ShowNotesCell()
            return cell.fillCell(note: currentContact.notes)
            
        case "phones":
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell ?? InfoCell()
            return cell.fillCell(title: "mobile", values: currentContact.phoneNumbers)
            
        case "emails":
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell ?? InfoCell()
            return cell.fillCell(title: "home", values: currentContact.emails)
        
        case "birthday":
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? InfoCell ?? InfoCell()
            return cell.fillCell(title: "birthday", values: [currentContact.birthDate])
        
        case "empty":
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as! EmptyCell
            return cell.fillCell()
        
            
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as? NameCell ?? NameCell()
            return cell.fillCell(name: "N", company: "")
        }
    }
}


// MARK: Table Delegate Methods
extension ContactInfoViewController: UITableViewDelegate {
    
       // Set the spacing between sections
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 15
       }
       // Make the background color show through
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }
}
