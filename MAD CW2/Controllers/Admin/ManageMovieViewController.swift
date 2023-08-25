//
//  ManageMovieViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/20/23.
//

import UIKit
import CoreData

class ManageMovieViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, MultipleOptionsViewControllerDelegate {
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var txtMovieRating: UITextField!
    @IBOutlet weak var txtMovieDesc: UITextView!
    @IBOutlet weak var txtMovieTrailer: UITextField!
    @IBOutlet weak var txtGenres: UITextField!
    @IBOutlet weak var txtReleaseDate: UITextField!
    @IBOutlet weak var txtMovieIMDB: UITextField!
    @IBOutlet weak var txtMovieName: UITextField!
    
    var identifier: String?
    var selectedMovie: Movie?
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
        
        txtMovieRating.keyboardType = .decimalPad
        
        //scrollView.contentSize = contentView.frame.size
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = false
        
        if(identifier == "Add"){
            self.navigationItem.title = "Add Movie"
        }else if(identifier == "Update"){
            self.navigationItem.title = "Update Movie"
            if let movie = selectedMovie {
                txtMovieName.text = movie.name
                txtMovieDesc.text = movie.desc
                txtGenres.text = movie.genres
                txtMovieTrailer.text = movie.youtubelink
                txtMovieIMDB.text = movie.imdblink
                txtMovieRating.text = String(movie.rating)
                
                imgMovie.image = CommonData.base64ToImage(movie.coverimage!)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let movieReleaseDate = movie.releaseDate{
                    txtReleaseDate.text = dateFormatter.string(from: movieReleaseDate)
                }
                print(movie.releaseDate)
            }
        }
        
        txtMovieName.delegate = self
        txtMovieRating.delegate = self
        txtMovieTrailer.delegate = self
        txtMovieIMDB.delegate = self
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
            if(self.identifier == "Add"){
                self.addMovie()
            }else if(self.identifier == "Update"){
                        self.updateMovie()
            }
        }

        let noAction = UIAlertAction(title: "No", style: .default) { _ in
            // Handle "No" button tap
            print("User tapped No")
        }

        alertController.addAction(yesAction)
        alertController.addAction(noAction)

        present(alertController, animated: true, completion: nil)
    }
    
    func addMovie(){
        do{
            let status = verifyFields()
            if(status){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                _ = Movie(coverimage: CommonData.imageToBase64(image: imgMovie.image!), desc: txtMovieDesc.text!, id: UUID().uuidString, imdblink: txtMovieIMDB.text!, name: txtMovieName.text!, rating: Double(txtMovieRating.text!) ?? 0.0, useroverallrating: 0.0, youtubelink: txtMovieTrailer.text!, releaseDate: dateFormatter.date(from: txtReleaseDate.text!), genres: txtGenres.text!, insertIntoManagedObjectContext: context!)
                try context?.save()
                
                let storyboard = UIStoryboard(name: "AdminHome", bundle: nil)
                let tabBarController = storyboard.instantiateViewController(withIdentifier: "adminHomeTabBar") as! UITabBarController
                navigationController!.setViewControllers([tabBarController], animated: true)
            }
        }catch{
            print("Movie create failed.")
        }
    }
    
    
    func updateMovie(){
        do{
            let status = verifyFields()
            if(status){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                selectedMovie?.coverimage = CommonData.imageToBase64(image: imgMovie.image!)
                selectedMovie?.desc = txtMovieDesc.text!
                selectedMovie?.imdblink = txtMovieIMDB.text!
                selectedMovie?.name = txtMovieName.text!
                selectedMovie?.rating = Double(txtMovieRating.text!) ?? 0.0
                selectedMovie?.youtubelink = txtMovieTrailer.text!
                selectedMovie?.releaseDate = dateFormatter.date(from: txtReleaseDate.text!)
                selectedMovie?.genres = txtGenres.text!
                try context?.save()
                
//                let storyboard = UIStoryboard(name: "AdminHome", bundle: nil)
//                let tabBarController = storyboard.instantiateViewController(withIdentifier: "adminHomeTabBar") as! UIViewController
//
//                navigationController!.setViewControllers([tabBarController], animated: true)
                navigationController?.popViewController(animated: true)
            }
        }catch{
            print("Movie create failed.")
        }
    }
    
    
    
    func verifyFields() -> Bool{
        var status = true
        let movieName = txtMovieName.text!.trimmingCharacters(in: .whitespaces)
        let movieDesc = txtMovieDesc.text!.trimmingCharacters(in: .whitespaces)
        let movieRating = txtMovieRating.text!.trimmingCharacters(in: .whitespaces)
        let movieTrailer = txtMovieTrailer.text!.trimmingCharacters(in: .whitespaces)
        let movieIMDB = txtMovieIMDB.text!.trimmingCharacters(in: .whitespaces)
        let movieGenre = txtGenres.text!.trimmingCharacters(in: .whitespaces)
        let movieReleaseDate = txtReleaseDate.text!.trimmingCharacters(in: .whitespaces)
        
        if(movieName == "" || movieDesc == "" || movieRating == "" || movieTrailer == "" || movieIMDB == "" || movieGenre == "" || movieReleaseDate == ""){
            showErrorPopup(message: "Fill all the field.")
            status = false
        }
        return status
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtMovieName.resignFirstResponder()
        txtMovieDesc.resignFirstResponder()
        txtMovieRating.resignFirstResponder()
        txtMovieTrailer.resignFirstResponder()
        txtMovieIMDB.resignFirstResponder()
        return true
    }
    
    func showErrorPopup(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
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
            imgMovie.contentMode = .scaleAspectFit
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
