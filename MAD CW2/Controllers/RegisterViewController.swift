//
//  RegisterViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/15/23.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var togglePassword = false
    var toggleConfirmPassword = false
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    
    @IBOutlet weak var lblSignIn: UILabel!
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var passwordToggle: UIImageView!
    @IBOutlet weak var confirmPasswordToggle: UIImageView!
    
    //Fields View
    @IBOutlet weak var firstNameView: UIView!
    @IBOutlet weak var lastNameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    //Fields Error Labels
    @IBOutlet weak var lblFirstNameError: UILabel!
    @IBOutlet weak var lblLastNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPhoneError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblConfirmPasswordError: UILabel!
    
    var titlePickerView = UIPickerView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlinedText = NSAttributedString(string: lblSignIn.text ?? "", attributes: underlineAttribute)
        lblSignIn.attributedText = underlinedText
        
        txtTitle.inputView = titlePickerView
        txtPhone.keyboardType = .numberPad
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        let toolbar = UIToolbar()
        toolbar.items = [doneButton]
        toolbar.sizeToFit()
        txtTitle.inputAccessoryView = toolbar
        txtPhone.inputAccessoryView = toolbar
        
        txtPassword.textContentType = .oneTimeCode
        txtConfirmPassword.textContentType = .oneTimeCode
        
        titlePickerView.delegate = self
        txtTitle.delegate = self
        txtFirstName.delegate = self
        txtLastName.delegate = self
        txtEmail.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtPhone.delegate = self
        
        txtTitle.text = CommonData.titles[0]
        
        lblFirstNameError.isHidden = true
        lblLastNameError.isHidden = true
        lblEmailError.isHidden = true
        lblPhoneError.isHidden = true
        lblPasswordError.isHidden = true
        lblConfirmPasswordError.isHidden = true
    }
    
    @IBAction func passwordToggleClick(_ sender: Any) {
        if(togglePassword){
            togglePassword = false
            passwordToggle.image = UIImage(systemName: "eye.fill")
        }else{
            togglePassword = true
            passwordToggle.image = UIImage(systemName: "eye.slash.fill")
        }
        txtPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func confirmPasswordToggleClick(_ sender: Any) {
        if(toggleConfirmPassword){
            toggleConfirmPassword = false
            confirmPasswordToggle.image = UIImage(systemName: "eye.fill")
        }else{
            toggleConfirmPassword = true
            confirmPasswordToggle.image = UIImage(systemName: "eye.slash.fill")
        }
        txtConfirmPassword.isSecureTextEntry.toggle()
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
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtConfirmPassword.resignFirstResponder()
        return true
    }
    
    @IBAction func registerOnClick(_ sender: Any) {
        do{
            var status = verifyFields()
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "User"
            )
            request.predicate = NSPredicate(format: "email == %@ ",txtEmail.text!)
            request.fetchLimit = 1
            let user = try self.context?.fetch(request) as? [User]
            if(user != nil && user?.count == 1){
                lblEmailError.text = "Email address already used."
                lblEmailError.isHidden = false
                emailView.layer.borderColor = UIColor.red.cgColor
                emailView.layer.borderWidth = 1
                status = false
            }
            if(status){
                _ = User(email: txtEmail.text!, firstname: txtFirstName.text!, id: UUID().uuidString, lastname: txtLastName.text!, password: txtPassword.text!, phone: txtPhone.text!, usertype: String(describing:  Enums.UserType.standard), title: txtTitle.text!, insertIntoManagedObjectContext: context!)
                try context?.save()
                print("User registration completed")
                
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let targetViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                navigationController?.pushViewController(targetViewController, animated: true)
            }
        }catch{
            print("User registration failed.")
        }
    }
    
    func verifyFields() -> Bool{
        var status = true
        let firstName = txtFirstName.text!.trimmingCharacters(in: .whitespaces)
        let lastName = txtLastName.text!.trimmingCharacters(in: .whitespaces)
        let email = txtEmail.text!.trimmingCharacters(in: .whitespaces)
        let phone = txtPhone.text!
        let password = txtPassword.text
        let confirmPassword = txtConfirmPassword.text
        
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
        if(email == "" || !Validations.isValidEmail(email)){
            lblEmailError.text = "Email field value is invalid."
            lblEmailError.isHidden = false
            emailView.layer.borderColor = UIColor.red.cgColor
            emailView.layer.borderWidth = 1
            status = false
        }
        if(phone == "" || phone.count > 10){
            lblPhoneError.text = "Phone field value is invalid."
            lblPhoneError.isHidden = false
            phoneView.layer.borderColor = UIColor.red.cgColor
            phoneView.layer.borderWidth = 1
            status = false
        }
        if(password == ""){
            lblPasswordError.text = "Password field value is invalid."
            lblPasswordError.isHidden = false
            passwordView.layer.borderColor = UIColor.red.cgColor
            passwordView.layer.borderWidth = 1
            status = false
        }else if(!Validations.isValidPassword(password ?? "")){
            lblPasswordError.text = "Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one digit, and one special character."
            lblPasswordError.isHidden = false
            passwordView.layer.borderColor = UIColor.red.cgColor
            passwordView.layer.borderWidth = 1
            status = false
        }
        if(confirmPassword == ""){
            lblConfirmPasswordError.text = "Confirm Password field value is invalid."
            lblConfirmPasswordError.isHidden = false
            confirmPasswordView.layer.borderColor = UIColor.red.cgColor
            confirmPasswordView.layer.borderWidth = 1
            status = false
        }else if(password != confirmPassword){
            lblConfirmPasswordError.text = "Confirm password mismatch."
            lblConfirmPasswordError.isHidden = false
            confirmPasswordView.layer.borderColor = UIColor.red.cgColor
            confirmPasswordView.layer.borderWidth = 1
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
        }else if(txtEmail == textField){
            emailView.layer.borderWidth = 0
            lblEmailError.isHidden = true
        }else if(txtPhone == textField){
            phoneView.layer.borderWidth = 0
            lblPhoneError.isHidden = true
        }else if(txtPassword == textField){
            passwordView.layer.borderWidth = 0
            lblPasswordError.isHidden = true
        }else if(txtConfirmPassword == textField){
            confirmPasswordView.layer.borderWidth = 0
            lblConfirmPasswordError.isHidden = true
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
