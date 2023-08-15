//
//  LoginViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/15/23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    var adminEmail: String = "admin@gmail.com"
    var adminPassword: String = "Admin@123"
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }

    @IBOutlet weak var lblRegister: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        // Apply underline attribute to the label's text
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue]
        let underlinedText = NSAttributedString(string: lblRegister.text ?? "", attributes: underlineAttribute)
        lblRegister.attributedText = underlinedText
        
        seedAdminLogin()
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
                _ = User(email: adminEmail, firstname: "Admin", id: UUID().uuidString, lastname: "Admin", password: adminPassword, phone: nil, usertype: "Admin", insertIntoManagedObjectContext: context!)
                try context?.save()
                print("Admin new user created")
            }
            print("Admin user creation completed")
        }catch{
            print("Admin user creation failed")
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
