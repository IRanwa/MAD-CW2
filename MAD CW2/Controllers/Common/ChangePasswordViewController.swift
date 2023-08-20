//
//  ChangePasswordViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/19/23.
//

import UIKit
import CoreData

class ChangePasswordViewController: UIViewController, UITextFieldDelegate  {
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    
    var currentPasswordToggleStatus = false
    var passwordToggleStatus = false
    var confirmPasswordToggleStatus = false
    
    @IBOutlet weak var lblLoginAs: UILabel!
    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var lblCurrentPasswordError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblConfirmPasswordError: UILabel!
    
    @IBOutlet weak var currentPasswordToggle: UIImageView!
    @IBOutlet weak var passwordToggle: UIImageView!
    @IBOutlet weak var confirmPassword: UIImageView!
    
    @IBOutlet weak var currentPasswordView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Update Password"
        lblLoginAs.text = UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.email))
        
        lblCurrentPasswordError.isHidden = true
        lblPasswordError.isHidden = true
        lblConfirmPasswordError.isHidden = true
        
        txtCurrentPassword.textContentType = .oneTimeCode
        txtPassword.textContentType = .oneTimeCode
        txtConfirmPassword.textContentType = .oneTimeCode
        
        txtCurrentPassword.delegate = self
        txtPassword.delegate = self
        txtConfirmPassword.delegate = self
    }
    
    @IBAction func currentPasswordOnClick(_ sender: Any) {
        if(currentPasswordToggleStatus){
            currentPasswordToggleStatus = false
            currentPasswordToggle.image = UIImage(systemName: "eye.fill")
        }else{
            currentPasswordToggleStatus = true
            currentPasswordToggle.image = UIImage(systemName: "eye.slash.fill")
        }
        txtCurrentPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func passwordOnClick(_ sender: Any) {
        if(passwordToggleStatus){
            passwordToggleStatus = false
            passwordToggle.image = UIImage(systemName: "eye.fill")
        }else{
            passwordToggleStatus = true
            passwordToggle.image = UIImage(systemName: "eye.slash.fill")
        }
        txtPassword.isSecureTextEntry.toggle()
    }
    
    @IBAction func confirmPasswordOnClick(_ sender: Any) {
        if(confirmPasswordToggleStatus){
            confirmPasswordToggleStatus = false
            confirmPassword.image = UIImage(systemName: "eye.fill")
        }else{
            confirmPasswordToggleStatus = true
            confirmPassword.image = UIImage(systemName: "eye.slash.fill")
        }
        txtConfirmPassword.isSecureTextEntry.toggle()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCurrentPassword.resignFirstResponder()
        txtPassword.resignFirstResponder()
        txtConfirmPassword.resignFirstResponder()
        return true
    }
    
    @IBAction func submitOnClick(_ sender: Any) {
        do{
            var status = verifyFields()
            var loginUser = User()
            let email = UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.email))
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "User"
            )
            request.predicate = NSPredicate(format: "email == %@ ", email ?? "")
            request.fetchLimit = 1
            let user = try self.context?.fetch(request) as? [User]
            if(user != nil && user?.count == 1){
                loginUser = user![0]
                if(loginUser.password != txtCurrentPassword.text){
                    lblCurrentPasswordError.text = "Invalid current password."
                    lblCurrentPasswordError.isHidden = false
                    currentPasswordView.layer.borderColor = UIColor.red.cgColor
                    currentPasswordView.layer.borderWidth = 1
                    status = false
                }
            }
            if(status){
                loginUser.password = txtPassword.text
                try context?.save()
                
                let storyboard = UIStoryboard(name: "UserHome", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "userHomeTabBar")
                navigationController?.pushViewController(tabBarController, animated: true)
            }
        }catch{
            print("User password update failed.")
        }
    }
    
    func verifyFields() -> Bool{
        var status = true
        let currentPassword = txtCurrentPassword.text
        let password = txtPassword.text
        let confirmPassword = txtConfirmPassword.text
        
        if(currentPassword == ""){
            lblCurrentPasswordError.text = "Password field value is invalid."
            lblCurrentPasswordError.isHidden = false
            currentPasswordView.layer.borderColor = UIColor.red.cgColor
            currentPasswordView.layer.borderWidth = 1
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
        }else if(currentPassword == password){
            lblPasswordError.text = "New password same as current password."
            lblPasswordError.isHidden = false
            passwordView.layer.borderColor = UIColor.red.cgColor
            passwordView.layer.borderWidth = 1
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
        if(txtCurrentPassword == textField){
            currentPasswordView.layer.borderWidth = 0
            lblCurrentPasswordError.isHidden = true
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
