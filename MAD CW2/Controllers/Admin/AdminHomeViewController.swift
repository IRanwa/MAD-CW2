//
//  AdminHomeViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/19/23.
//

import UIKit

class AdminHomeViewController: UITabBarController, UITabBarControllerDelegate {
    
    
    var identifier: String?
    var leftbarButtonItem = UIBarButtonItem()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.selectedIndex = 0
        
        self.navigationController?.navigationBar.isHidden = false
        
        self.navigationItem.title = "Movies"
        self.navigationItem.backBarButtonItem?.isEnabled = false
        self.navigationItem.rightBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Add")?.resized(to: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(createMovie))
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func createMovie() {
        print("createMovie")
        let storyboard = UIStoryboard(name: "ManageMovie", bundle: nil)
        let destinationViewController = storyboard.instantiateViewController(withIdentifier: "ManageMovieView") as! ManageMovieViewController
        destinationViewController.identifier = "Add"
        navigationController!.pushViewController(destinationViewController, animated: true)
        
    }
    
    
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController)
        if let index = selectedIndex {
            if(index == 0){
                self.navigationController?.navigationBar.isHidden = false
                
                self.navigationItem.title = "Movies"
                self.navigationItem.backBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "Add")?.resized(to: CGSize(width: 30, height: 30)), style: .plain, target: self, action: #selector(createMovie))
            }else if(index == 1){
                self.navigationController?.navigationBar.isHidden = false
                
                self.navigationItem.title = "Settings"
                self.navigationItem.backBarButtonItem?.isEnabled = false
                self.navigationItem.rightBarButtonItem?.isHidden = true
            }else{
                self.navigationController?.navigationBar.isHidden = true
            }
        }
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("seleceted item")
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

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(origin: .zero, size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}





