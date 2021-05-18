//
//  AddContactViewController.swift
//  ContactBook
//
//  Created by user on 12.02.2021.
//

import UIKit

public class AddContactViewController: UIViewController{
    
    
    // MARK: Cells Models Array
    var contactCellModels: [TableCell] = []
    


    // MARK: Interface elements
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var fieldsTable: UITableView!
    var imgView: UIImageView = UIImageView()
    var birthDayField = UITextField()
    @IBOutlet weak var titleItem: UINavigationItem!
    
    
    var sendedContact: Contact?
    var contactToShow = Contact()
    

   
    // MARK: Lifecycle methods
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = .bgColor
        view.backgroundColor = .bgColor
        fieldsTable.backgroundColor = .bgColor
        fieldsTable.dataSource = self
    }
    
    
    public override func viewWillAppear(_ animated: Bool) {
        contactToShow = Contact()
        if let con = sendedContact {
            titleItem.title = ""
            contactToShow = con }
        defineCellModels()
    }
    
    
    // MARK: defining cell models
    
    func defineCellModels() {
        contactCellModels.append(ImageCellModel(img: contactToShow.image))
        contactCellModels.append(TextFieldCellModel(placeholder: "First Name", text: contactToShow.firstName))
        contactCellModels.append(TextFieldCellModel(placeholder: "Last Name", text: contactToShow.lastName))
        contactCellModels.append(TextFieldCellModel(placeholder: "Company", text: contactToShow.company))
        contactCellModels.append(EmptyCellModel())
        for phone in contactToShow.phoneNumbers {
            contactCellModels.append(AddCellModel(placeholder: "Phone", label: "mobile", text: phone))
        }
        contactCellModels.append(CellWithButtonModel(text: "add phone"))
        contactCellModels.append(EmptyCellModel())
        for email in contactToShow.emails {
            contactCellModels.append(AddCellModel(placeholder: "Email", label: "home", text: email))
        }
        contactCellModels.append(CellWithButtonModel(text: "add email"))
        contactCellModels.append(EmptyCellModel())
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        if contactToShow.birthDate != "" {
            contactCellModels.append(AddCellModel(placeholder: "\(dateFormatter.string(from: Date()))", label: "birthday", text: contactToShow.birthDate))
        }
        contactCellModels.append(CellWithButtonModel(text: "add birtday"))
        contactCellModels.append(EmptyCellModel())
        contactCellModels.append(NotesCellModel(notes: contactToShow.notes))
        contactCellModels.append(EmptyCellModel())
        if let _ = sendedContact {
            contactCellModels.append(DeleteCellModel())
            contactCellModels.append(EmptyCellModel())
        }
    }

    


    
    // MARK: Succesful Adding
    @IBAction func addNewContact(_ sender: Any) {
        let newContact: Contact = Contact()
        newContact.image = imgView.image ?? UIImage()
        
        var model = contactCellModels[1] as? TextFieldCellModel ?? TextFieldCellModel(placeholder: "", text: "")
        newContact.firstName = model.text
        
        model = contactCellModels[2] as? TextFieldCellModel ?? TextFieldCellModel(placeholder: "", text: "")
        newContact.lastName = model.text
    
        model = contactCellModels[3] as? TextFieldCellModel ?? TextFieldCellModel(placeholder: "", text: "")
        newContact.company = model.text
        
        var i = 5
        while contactCellModels[i].type == "addCell" {
            let phoneCell = contactCellModels[i] as! AddCellModel
//                ?? AddCellModel(placeholder: "", label: "", text: "")
            if phoneCell.text != "" {
                newContact.phoneNumbers.append(phoneCell.text)
            }
            i += 1
        }
        i += 2
        while contactCellModels[i].type == "addCell" {
            let mailCell = contactCellModels[i] as? AddCellModel ?? AddCellModel(placeholder: "", label: "", text: "")

            if mailCell.text != "" {
                newContact.emails.append(mailCell.text)
            }
            i += 1
        }
        var minus = 0
        if let _ = sendedContact {
            minus = 2
        }
        i = contactCellModels.count - 2 - minus
        let notesCell = contactCellModels[i] as? NotesCellModel ?? NotesCellModel(notes: "")
        newContact.notes = notesCell.notes
        
        
        i = contactCellModels.count - 5 - minus
        if contactCellModels[i].type == "addCell" {
            let dateCell = contactCellModels[i] as? AddCellModel ?? AddCellModel(placeholder: "", label: "", text: "")
            if dateCell.text != "" {
                newContact.birthDate = dateCell.text
            }
        }
        
        
        if newContact.lastName != "" {
            newContact.defining = newContact.lastName
        }
        else if newContact.firstName != "" {
            newContact.defining = newContact.firstName
        }
        else if newContact.company != "" {
            newContact.defining = newContact.company
        }
        else if newContact.phoneNumbers.count != 0 {
            newContact.defining = newContact.phoneNumbers[0]
        }
        else if newContact.emails.count != 0 {
            newContact.defining = newContact.emails[0]
        }
        else if newContact.birthDate != "" || newContact.notes != "" {
            newContact.defining = "#No name"
        }
        else {
            return
        }
        contactBook.removeContact(contact: contactToShow)
        contactBook.addContact(contact: newContact)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)

        if let _ = sendedContact {
            let presentingVC = self.presentingViewController as? ContactInfoViewController ?? ContactInfoViewController()
            presentingVC.currentContact = newContact
            presentingVC.detailsTable.reloadData()
            presentingVC.defineFields()
            sendedContact = nil
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
        }
        else {
            sendedContact = nil
            self.dismiss(animated: true, completion: nil)
        }
        
    }
        
    
    // MARK: discardAdding
    @IBAction func discardAdding(_ sender: Any) {
        if let _ = sendedContact {
            let transition: CATransition = CATransition()
            transition.duration = 0.3
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.fade
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
 
        
    // MARK: deleting contact
    @objc public func removeContact(_ sender: UIButton) {
        contactBook.removeContact(contact: contactToShow)
        sendedContact = nil
        let transition: CATransition = CATransition()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
}




// MARK: ImagePicker methods
extension AddContactViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @objc public func addPhoto(_sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .savedPhotosAlbum
        vc.allowsEditing = true
        vc.delegate = self
        present(vc, animated: true)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.layer.cornerRadius = imgView.frame.width / 2
        imgView.layer.masksToBounds = true
        imgView.clipsToBounds = true
        imgView.image = newImage
        contactToShow.image = newImage
        dismiss(animated: true)
    }
}




// MARK: TableView DataSource methods
extension AddContactViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactCellModels.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellModel = contactCellModels[indexPath.row]
        
        if cellModel.type == "imageCell" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageCell
            cell.addPhotoButton.addTarget(self, action: #selector(addPhoto(_sender:)) , for: .touchUpInside)
            imgView = cell.img
            if titleItem.title == "" {
                cell.addPhotoButton.titleLabel?.text = "Change photo"
            }
            return cell.fillCell(image: contactToShow.image)
        }
        
        if cellModel.type == "textFieldCell" {
            let model = cellModel as! TextFieldCellModel
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! TextFieldCell
            
            cell.textField.removeTarget(self, action: nil, for: .touchUpInside)
            cell.textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            return cell.fillCell(placeholder: model.placeholder, text: model.text)
        }
        
        if cellModel.type == "emptyCell" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "emptyCell", for: indexPath) as! EmptyCell
            return cell.fillCell()
        }
        
        if cellModel.type == "cellWithButton" {
            let model = cellModel as! CellWithButtonModel
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! CellWithButton
            
            // removing all target actions
            cell.addButton.removeTarget(self, action: nil, for: .touchUpInside)
  
            
            // adding appropriate target action
            if model.text == "add phone" {
                cell.addButton.addTarget(self, action: #selector(addPhoneField(byClickOn:)), for: .touchUpInside)}
            else if model.text == "add email" {
                cell.addButton.addTarget(self, action: #selector(addEmailField(byClickOn:)), for: .touchUpInside)}
            else if model.text == "add birtday" {
                cell.addButton.addTarget(self, action: #selector(addBirthdayField(byClickOn:)), for: .touchUpInside)}
            
            return cell.fillCell(text: model.text)
        }
        
        
        if cellModel.type == "addCell" {
            let model = cellModel as! AddCellModel
            let cell = tableView.dequeueReusableCell(withIdentifier: "addInfoCell",for: indexPath) as! AddCell
            
            // removing all target actions
            cell.deleteButton.removeTarget(self, action: nil, for: .touchUpInside)
            cell.textField.removeTarget(self, action: nil, for: .editingChanged)

            
            // adding appropriate target action
            if model.label == "mobile" {
                cell.deleteButton.addTarget(self, action: #selector(deletePhoneField(_:)), for: .touchUpInside)}
            else if model.label == "home" {
                cell.deleteButton.addTarget(self, action: #selector(deleteEmailField(_:)), for: .touchUpInside)}
            else if model.label == "birthday" {
                cell.deleteButton.addTarget(self, action: #selector(deleteBirtdayField(_:)), for: .touchUpInside)}
            cell.textField.addTarget(self, action: #selector(valueDidChange(_:)), for: .editingChanged)
        
            return cell.fillCell(placeholder: model.placeholder, label: model.label, text: model.text)
        }
        
        if cellModel.type == "notesCell" {
            let model = cellModel as! NotesCellModel
            let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesCell
            cell.noteTextView.delegate = self
            return cell.fillCell(note: model.notes)
        }
        
        if cellModel.type == "deleteCell" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "deleteCell", for: indexPath) as! DeleteCell
            cell.deleteButton.removeTarget(self, action: nil, for: .touchUpInside)
            cell.deleteButton.addTarget(self, action: #selector(removeContact(_:)), for: .touchUpInside)
            return cell
            
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
    }
    



    
    
    
    
    
// MARK: Handling cell's button actions
    
    @objc public func addPhoneField(byClickOn sender: UIButton) {
        
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPath(for: cell)
        contactCellModels.insert(AddCellModel(placeholder: "Phone", label: "mobile", text: ""), at: indexPath!.row)
        fieldsTable.insertRows(at: [indexPath!], with: .fade)
    }
    
    
    @objc public func addEmailField(byClickOn sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPath(for: cell)
        contactCellModels.insert(AddCellModel(placeholder: "Email", label: "home", text: ""), at: indexPath!.row)
        fieldsTable.insertRows(at: [indexPath!], with: .fade)
    }
    
    
    @objc public func addBirthdayField(byClickOn sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPath(for: cell)
        if contactCellModels[(indexPath?.row ?? 1) - 1].type == "addCell" {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        contactCellModels.insert(AddCellModel(placeholder: "\(dateFormatter.string(from: Date()))", label: "birthday", text: "" ), at: indexPath?.row ?? 0)
        fieldsTable.insertRows(at: [indexPath!], with: .fade)
        let birthdayCell = fieldsTable.cellForRow(at: IndexPath(row: (indexPath?.row ?? 0) + 1, section: 0)) as! CellWithButton
        birthdayCell.addButton.tintColor = .systemGray4
        
        let addCell = fieldsTable.cellForRow(at: indexPath!) as! AddCell
        let datePicker = UIDatePicker()
        birthDayField = addCell.textField
        birthDayField.inputView = datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(handleDatePicker(sender:)), for: .editingDidEnd)
    }
    
    
    @objc func handleDatePicker(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd")
        let strDate = dateFormatter.string(from: sender.date)
        birthDayField.text = strDate
        birthDayField.endEditing(true)
    }
    
    
    @objc public func deletePhoneField(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPathForRow(at: cell.center)
        contactCellModels.remove(at: indexPath!.row)
        fieldsTable.deleteRows(at: [indexPath ?? IndexPath(row: 0,section : 0)], with: .fade)
        
    }
    
    @objc public func deleteEmailField(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPathForRow(at: cell.center)
        contactCellModels.remove(at: indexPath!.row)
        fieldsTable.deleteRows(at: [indexPath!], with: .fade)
    }
    
    @objc public func deleteBirtdayField(_ sender: UIButton) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPathForRow(at: cell.center)
        contactCellModels.remove(at: indexPath!.row)
        fieldsTable.deleteRows(at: [indexPath!], with: .fade)
        let birthdayCell = fieldsTable.cellForRow(at: IndexPath(row: (indexPath?.row ?? 0), section: 0)) as! CellWithButton
        birthdayCell.addButton.tintColor = .systemGreen
    }
    
    @objc public func textFieldDidChange(_ sender: UITextField) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPathForRow(at: cell.center)
        let model = contactCellModels[indexPath!.row] as! TextFieldCellModel
        model.text = sender.text ?? ""
    }
    
    @objc public func valueDidChange(_ sender: UITextField) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPathForRow(at: cell.center)
        let model = contactCellModels[indexPath!.row] as! AddCellModel
        model.text = sender.text ?? ""
    }
}




extension AddContactViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         if contactCellModels[indexPath.row].type == "cellWithButton" {
             let cell = tableView.cellForRow(at: indexPath) as! CellWithButton
             cell.addButton.sendActions(for: .touchUpInside)
         }
         tableView.deselectRow(at: indexPath, animated: true)
     }
}


extension AddContactViewController: UITextViewDelegate {
    public func textViewDidChange(_ sender: UITextView) {
        let cell = sender.superview?.superview as! UITableViewCell
        let indexPath = fieldsTable.indexPathForRow(at: cell.center)
        let model = contactCellModels[indexPath!.row] as! NotesCellModel
        model.notes = sender.text ?? ""
        
    }
}




