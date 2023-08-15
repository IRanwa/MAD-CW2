//
//  RegisterViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/15/23.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var lblSignIn: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.isHidden = true
        
        // Apply underline attribute to the label's text
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlinedText = NSAttributedString(string: lblSignIn.text ?? "", attributes: underlineAttribute)
        lblSignIn.attributedText = underlinedText
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
