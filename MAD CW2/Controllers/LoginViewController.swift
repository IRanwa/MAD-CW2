//
//  LoginViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/15/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, UITextFieldDelegate {
    var adminEmail: String = "admin@gmail.com"
    var adminPassword: String = "Admin@123"
    var togglePassword = false
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }

    @IBOutlet weak var lblRegister: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var passwordToggleImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        // Apply underline attribute to the label's text
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlinedText = NSAttributedString(string: lblRegister.text ?? "", attributes: underlineAttribute)
        lblRegister.attributedText = underlinedText
        seedAdminLogin()
        
        txtPassword.textContentType = .oneTimeCode
        
        lblEmailError.isHidden = true
        lblPasswordError.isHidden = true
        
        txtEmail.delegate = self
        txtPassword.delegate = self
    }
    
    func seedAdminLogin(){
        let request = NSFetchRequest<NSFetchRequestResult>(
            entityName: "User"
        )
        request.predicate = NSPredicate(format: "email == %@ ",adminEmail)
        request.fetchLimit = 1
        do{
            let adminUser = try self.context?.fetch(request) as? [User]
            if(adminUser == nil || (adminUser != nil && adminUser?.count == 0)){
                _ = User(email: adminEmail, firstname: "Admin", id: UUID().uuidString, lastname: "Admin", password: adminPassword, phone: nil, usertype: String(describing: Enums.UserType.admin), title: nil, insertIntoManagedObjectContext: context!)
                try context?.save()
                print("Admin new user created")
            }
            print("Admin user creation completed")
        }catch{
            print("Admin user creation failed")
        }
    }

    func showErrorPopup(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtEmail.resignFirstResponder()
        txtPassword.resignFirstResponder()
        return true
    }
    
    @IBAction func submitOnClick(_ sender: Any) {
        do{
            let status = verifyFields()
            if(status){
                let request = NSFetchRequest<NSFetchRequestResult>(
                    entityName: "User"
                )
                request.predicate = NSPredicate(format: "email == %@ ",txtEmail.text!)
                request.fetchLimit = 1
                let user = try self.context?.fetch(request) as? [User]
                if(user != nil && user?.count == 1){
                    let loginUser = user![0]
                    if let userType = loginUser.usertype{
                        let password = loginUser.password!
                        let email = loginUser.email!
                        if(userType == String(describing:  Enums.UserType.standard)){
                            if(password != txtPassword.text){
                                showErrorPopup(message: "User login credentials invalid.")
                            }else{
                                UserDefaults.standard.set(email, forKey: String(describing: Enums.UserDefaultKeys.email))
                                UserDefaults.standard.set(userType, forKey: String(describing: Enums.UserDefaultKeys.userType))
                                let storyboard = UIStoryboard(name: "UserHome", bundle: nil)
                                let tabBarController = storyboard.instantiateViewController(withIdentifier: "userHomeTabBar")
                                navigationController?.pushViewController(tabBarController, animated: true)
                            }
                        }else{
                            if(password != txtPassword.text){
                                showErrorPopup(message: "User login credentials invalid.")
                            }else{
                                UserDefaults.standard.set(email, forKey: String(describing: Enums.UserDefaultKeys.email))
                                UserDefaults.standard.set(userType, forKey: String(describing: Enums.UserDefaultKeys.userType))
                                let storyboard = UIStoryboard(name: "AdminHome", bundle: nil)
                                let tabBarController = storyboard.instantiateViewController(withIdentifier: "adminHomeTabBar")
                                navigationController?.pushViewController(tabBarController, animated: true)
                            }
                        }
                    }
                    
                }else{
                    showErrorPopup(message: "User login credentials invalid.")
                }
            }
        }catch{
            print("User signin failed.")
        }
    }
    
    func verifyFields() -> Bool{
        var status = true
        let email = txtEmail.text!.trimmingCharacters(in: .whitespaces)
        let password = txtPassword.text
        
        if(email == "" || !Validations.isValidEmail(email)){
            lblEmailError.text = "Email field value is invalid."
            lblEmailError.isHidden = false
            emailView.layer.borderColor = UIColor.red.cgColor
            emailView.layer.borderWidth = 1
            status = false
        }
        if(password == ""){
            lblPasswordError.text = "Password field value is invalid."
            lblPasswordError.isHidden = false
            passwordView.layer.borderColor = UIColor.red.cgColor
            passwordView.layer.borderWidth = 1
            status = false
        }
        return status
    }
    
    @IBAction func passwordToggleClick(_ sender: Any) {
        if(togglePassword){
            togglePassword = false
            passwordToggleImg.image = UIImage(systemName: "eye.fill")
        }else{
            togglePassword = true
            passwordToggleImg.image = UIImage(systemName: "eye.slash.fill")
        }
        txtPassword.isSecureTextEntry.toggle()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString txtVal: String) -> Bool {
        if(txtEmail == textField){
            emailView.layer.borderWidth = 0
            lblEmailError.isHidden = true
        }else if(txtPassword == textField){
            passwordView.layer.borderWidth = 0
            lblPasswordError.isHidden = true
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
