//
//  ChangePasswordViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/19/23.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    var currentPasswordToggleStatus = false
    var passwordToggleStatus = false
    var confirmPasswordToggleStatus = false
    
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
    @IBOutlet weak var lblCurrentPassword: UILabel!
    @IBOutlet weak var lblPassword: UILabel!
    @IBOutlet weak var lblConfirmPassword: UILabel!
    
    @IBOutlet weak var currentPasswordToggle: UIImageView!
    @IBOutlet weak var passwordToggle: UIImageView!
    @IBOutlet weak var confirmPassword: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Update Password"
        
        lblCurrentPassword.isHidden = false
        lblPassword.isHidden = false
        lblConfirmPassword.isHidden = false
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
    
    @IBAction func submitOnClick(_ sender: Any) {
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
