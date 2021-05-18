//
//  ContactsPageViewController.swift
//  ContactBook
//
//  Created by user on 12.02.2021.
//

import UIKit

public class ContactsPageViewController: UIViewController {
    
    // MARK: UI variables
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var contactTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var navItem: UINavigationItem!
    
    
    // MARK: variables
    var filteredContacts: [Contact] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isFiltering = false
    
    
    // MARK: lifecycle methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        contactTable.delegate = self
        contactTable.dataSource = self
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .bgColor
        
        searchBar.layer.borderColor = UIColor.bgColor.cgColor
        searchBar.layer.borderWidth = 1
        searchBar.barTintColor = .bgColor
        view.backgroundColor = .bgColor
        searchBar.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    
    
    // MARK: preparing for segues
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moveToInfoVCsegue" {
            
            let contactInfoController = segue.destination as! ContactInfoViewController
            contactInfoController.modalPresentationStyle = .fullScreen
            let indexInTable = contactTable.indexPath(for: sender as! UITableViewCell)
            if !isFiltering {
                let section = contactTable.headerView(forSection: indexInTable!.section )?.textLabel?.text
                let contact_id = contactBook.contactsByLetters[(section?.lowercased())!]![indexInTable!.row]
                contactInfoController.currentContact = contactBook.contacts[contact_id] ?? Contact()
            }
            else {
                contactInfoController.currentContact = filteredContacts[indexInTable?.row ?? 0]
            }
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromRight
            self.view.window!.layer.add(transition, forKey: nil)
        }
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
        refresh()
    }

//public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//    if segue.identifier == "unwindSegue" {
//        let primaryVC = segue.destination as? ContactsPageViewController ?? ContactsPageViewController()
//        primaryVC.contactTable.reloadData()
//    }
//}

    
    
    // MARK: manipulating with contacts table
    @objc func refresh() {
        contactTable.reloadData()
    }
    
}





// MARK: TableView DataSource
extension ContactsPageViewController: UITableViewDataSource {
  
    public func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return 1
        }
        return contactBook.contactsByLetters.count
    }
    
    

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let letters = contactBook.sortedLetters
        if isFiltering {
            return filteredContacts.count
        }
        return contactBook.contactsByLetters[letters[section]]?.count ?? 0
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if isFiltering {
            return nil
        }
        let letters = contactBook.sortedLetters
        return letters[section].uppercased()
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var contact = Contact()
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        if isFiltering {
            contact = filteredContacts[indexPath.row]
        }
        else {
            let letters = contactBook.sortedLetters
            let ids = contactBook.contactsByLetters[letters[indexPath.section]]
            let id = ids?[indexPath.row] ?? 0
            contact = contactBook.contacts[id] ?? Contact()
        }
        cell.textLabel?.attributedText = contact.showString
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        index
    }
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isFiltering {
            return []
        }
        return contactBook.sortedLetters.map( { $0.uppercased() })
    }
}


// MARK: TableView Delegate
extension ContactsPageViewController: UITableViewDelegate {

}

// MARK: Search bar controller
extension ContactsPageViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            isFiltering = true
            let contacts: [Contact] = contactBook.contacts.map({ $0.value })
            filteredContacts = contacts.filter( { $0.showString.string.lowercased().contains(searchText.lowercased()) })
        }
        else {
            isFiltering = false
        }
        contactTable.reloadData()
    }
}
