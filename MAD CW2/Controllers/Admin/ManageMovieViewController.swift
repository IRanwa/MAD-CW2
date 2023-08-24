//
//  ManageMovieViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/20/23.
//

import UIKit

class ManageMovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MultipleOptionsViewControllerDelegate {
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    //@IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var txtMovieRating: UILabel!
    @IBOutlet weak var txtMovieDesc: UITextView!
    @IBOutlet weak var txtMovieTrailer: UITextField!
    @IBOutlet weak var txtMoviewName: UITextField!
    @IBOutlet weak var txtGenres: UITextField!
    @IBOutlet weak var txtReleaseDate: UITextField!
    
    var identifier: String?
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        txtReleaseDate.inputView = datePicker
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(datePickerDoneOnClick))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        txtReleaseDate.inputAccessoryView = toolbar
        
        
        //scrollView.contentSize = contentView.frame.size
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
    
    @objc func datePickerDoneOnClick(){
        txtReleaseDate.resignFirstResponder()
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        txtReleaseDate.text = dateFormatter.string(from: sender.date)
    }
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        let alertController = UIAlertController(title: self.navigationItem.title, message: "Are you sure you want to proceed?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
            // Handle "Yes" button tap
            print("User tapped Yes")
        }
        
        let noAction = UIAlertAction(title: "No", style: .default) { _ in
            // Handle "No" button tap
            print("User tapped No")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
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
    
    @IBAction func genresOnClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MultipleOptionsPicker", bundle: nil)
        if let multipleOptionsViewController = storyboard.instantiateViewController(identifier: "MultipleOptionsPickerViewController") as? MultipleOptionsPickerViewController {
            multipleOptionsViewController.delegate = self
            multipleOptionsViewController.options = CommonData.genres
            multipleOptionsViewController.selectedOptions =
            txtGenres.text?.components(separatedBy: ",")
                .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } as! [String]
            navigationController?.showDetailViewController(multipleOptionsViewController, sender: nil)
        }
    }
    
    func didSelectOptions(options: [String]) {
        let cleanedOptions = options.filter { !$0.isEmpty }
        txtGenres.text = cleanedOptions.joined(separator: ", ")
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
