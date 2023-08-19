//
//  SettingsViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/16/23.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var myAccountView: UIView!
    @IBOutlet weak var faqView: UIView!
    @IBOutlet weak var changePasswordView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userType))
           == String(describing: Enums.UserType.admin)){
            myAccountView.isHidden = true
            faqView.isHidden = true
            changePasswordView.isHidden = true
        }
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
