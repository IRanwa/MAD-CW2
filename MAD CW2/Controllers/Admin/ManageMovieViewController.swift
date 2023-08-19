//
//  ManageMovieViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/20/23.
//

import UIKit

class ManageMovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    var identifier: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = contentView.frame.size
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if(identifier == "Add"){
            self.navigationItem.title = "Add Movie"
        }else if(identifier == "Update"){
            self.navigationItem.title = "Update Movie"
        }

        // Do any additional setup after loading the view.
    }
    
    
    @objc func saveButtonTapped() {
    }
    
    @objc func updateButtonTapped() {
    }
    
    
    @IBAction func movieImageTapped(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imgMovie.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
