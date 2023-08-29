//
//  MovieListViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/15/23.
//

import UIKit
import CoreData

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    var moviesList = [Movie]()
    var selectedMovie: Movie?
    
    @IBOutlet weak var moviesTblView: UITableView!
    @IBOutlet weak var txtMovieSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies"
        moviesTblView.delegate = self
        moviesTblView.dataSource = self
        
        txtMovieSearch.delegate = self
        loadMoviesList(movieName: "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtMovieSearch.resignFirstResponder()
        return true
    }
    
    func loadMoviesList(movieName: String){
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Movie"
            )
            request.predicate = NSPredicate(format: "name LIKE[c] %@", "*\(movieName)*")
            let movies = try self.context?.fetch(request) as? [Movie]
            if(movies != nil && movies!.count > 0){
                self.moviesList = movies!
                
            }else{
                self.moviesList = []
            }
            moviesTblView.reloadData()
        }catch{
            print("Movies loading failed")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = moviesList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailTblViewCell", for: indexPath) as! AdminMovieDetailTableViewCell
        cell.movieImg?.image = CommonData.base64ToImage(movie.coverimage!)
        cell.movieTitleLbl.text = movie.name
        cell.movieGenresLbl.text = movie.genres?.replacingOccurrences(of: ",", with: " |")
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray
        
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let movie = moviesList[indexPath.row]
            let alertController = UIAlertController(title: self.navigationItem.title, message: "Are you sure you want to proceed?", preferredStyle: .alert)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
                do{
                    self.context?.delete(movie)
                    try self.context?.save()
                    self.moviesList.remove(at: indexPath.row)
                    self.moviesTblView.reloadData()
                }catch{
                    print("Movie remove failed")
                }
            }
            
            let noAction = UIAlertAction(title: "No", style: .default) { _ in
                print("User tapped No")
            }
            
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMovie = moviesList[indexPath.row]
        performSegue(withIdentifier: "ShowMovieDetail", sender: self)
                                  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch(segue.identifier ?? ""){
            
            
        case "ShowMovieDetail":
            guard let detailviewcontroller = segue.destination as? MovieDetailViewController
            else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            detailviewcontroller.selectedMovie = selectedMovie
            detailviewcontroller.context = self.context
            detailviewcontroller.identifierDetail = segue.identifier
            
        default:
            fatalError("Unexpected seague identifier \(String(describing: segue.identifier))")
        }
    }
    
    @IBAction func searchOnClick(_ sender: Any) {
        loadMoviesList(movieName: txtMovieSearch.text ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadMoviesList(movieName: "")
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
