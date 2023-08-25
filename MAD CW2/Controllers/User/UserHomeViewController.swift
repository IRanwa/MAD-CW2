//
//  UserHomeViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/19/23.
//

import UIKit

class UserHomeViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.delegate = self
        self.selectedIndex = 2
        setTabBarTitle(self.selectedIndex)
        // Do any additional setup after loading the view.
    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)
        setTabBarTitle(selectedIndex!)
    }
    
    func setTabBarTitle(_ currentselectedIndex: Int){
        if(currentselectedIndex == 0){
            self.title = "Favourites"
        }else if(currentselectedIndex == 1){
            self.title = "Statistics"
        }else if(currentselectedIndex == 2){
            self.title = "Movies"
        }else if(currentselectedIndex == 3){
            self.title = "Rating history"
        }else if(currentselectedIndex == 4){
            self.title = "Settings"
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
