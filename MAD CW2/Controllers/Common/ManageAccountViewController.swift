//
//  ManageAccountViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/19/23.
//

import UIKit
import CoreData

class ManageAccountViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    
    @IBOutlet weak var lblLoginAs: UILabel!
    
    @IBOutlet weak var lblFirstNameError: UILabel!
    @IBOutlet weak var lblLastNameError: UILabel!
    @IBOutlet weak var lblPhoneError: UILabel!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var phoneView: UIView!
    
    var titlePickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Manage Account"
        
        lblLoginAs.text = UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.email))
        
        lblFirstNameError.isHidden = true
        lblLastNameError.isHidden = true
        lblPhoneError.isHidden = true
        
        txtTitle.inputView = titlePickerView
        txtPhone.keyboardType = .numberPad
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let toolbar = UIToolbar()
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        txtTitle.inputAccessoryView = toolbar
        txtPhone.inputAccessoryView = toolbar
        
        titlePickerView.delegate = self
        txtTitle.delegate = self
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtPhone.delegate = self
        
        txtTitle.text = CommonData.titles[0]
        loadUserDetails()
    }
    
    func loadUserDetails(){
        do{
            let email = UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.email))
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "User"
            )
            request.predicate = NSPredicate(format: "email == %@ ", email ?? "")
            request.fetchLimit = 1
            let user = try self.context?.fetch(request) as? [User]
            if(user != nil && user?.count == 1){
                let loginUser = user![0]
                txtTitle.text = loginUser.title
                txtFirstName.text = loginUser.firstname
                txtLastName.text = loginUser.lastname
                txtPhone.text = loginUser.phone
            }
        }catch{
            print("User details loading failed.")
        }
    }
    
    @objc func doneButtonTapped() {
        txtTitle.resignFirstResponder()
        txtPhone.resignFirstResponder()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CommonData.titles.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CommonData.titles[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtTitle.text = CommonData.titles[row]
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtFirstName.resignFirstResponder()
        txtLastName.resignFirstResponder()
        return true
    }

    @IBAction func submitOnClick(_ sender: Any) {
        do{
            let status = verifyFields()
            if(status){
                let email = UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.email))
                let request = NSFetchRequest<NSFetchRequestResult>(
                    entityName: "User"
                )
                request.predicate = NSPredicate(format: "email == %@ ", email ?? "")
                request.fetchLimit = 1
                let user = try self.context?.fetch(request) as? [User]
                if(user != nil && user?.count == 1){
                    let loginUser = user![0]
                    loginUser.firstname = txtFirstName.text
                    loginUser.lastname = txtLastName.text
                    loginUser.phone = txtPhone.text
                    loginUser.title = txtTitle.text
                    try context?.save()
                    
                    let storyboard = UIStoryboard(name: "UserHome", bundle: nil)
                    let tabBarController = storyboard.instantiateViewController(withIdentifier: "userHomeTabBar")
                    navigationController?.pushViewController(tabBarController, animated: true)
                }
            }
        }catch{
            print("User details update failed.")
        }
    }
    
    func verifyFields() -> Bool{
        var status = true
        let firstName = txtFirstName.text!.trimmingCharacters(in: .whitespaces)
        let lastName = txtLastName.text!.trimmingCharacters(in: .whitespaces)
        let phone = txtPhone.text!
        
        if(firstName == ""){
            lblFirstNameError.text = "First Name field value is invalid."
            lblFirstNameError.isHidden = false
            firstNameView.layer.borderColor = UIColor.red.cgColor
            firstNameView.layer.borderWidth = 1
            status = false
        }
        if(lastName == ""){
            lblLastNameError.text = "Last Name field value is invalid."
            lblLastNameError.isHidden = false
            lastNameView.layer.borderColor = UIColor.red.cgColor
            lastNameView.layer.borderWidth = 1
            status = false
        }
        if(phone == "" || phone.count > 10){
            lblPhoneError.text = "Phone field value is invalid."
            lblPhoneError.isHidden = false
            phoneView.layer.borderColor = UIColor.red.cgColor
            phoneView.layer.borderWidth = 1
            status = false
        }
        return status
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString txtVal: String) -> Bool {
        if(txtFirstName == textField){
            firstNameView.layer.borderWidth = 0
            lblFirstNameError.isHidden = true
        }else if(txtLastName == textField){
            lastNameView.layer.borderWidth = 0
            lblLastNameError.isHidden = true
        }else if(txtPhone == textField){
            phoneView.layer.borderWidth = 0
            lblPhoneError.isHidden = true
        }
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
