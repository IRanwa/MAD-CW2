//
//  RateHistoryViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//

import UIKit
import CoreData

class RateHistoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    var ratingList = [MovieRating]()
    var selectedMovie: Movie?
    
    @IBOutlet weak var moviesTblView: UITableView!
    @IBOutlet weak var txtMovieSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moviesTblView.delegate = self
        moviesTblView.dataSource = self
        loadMoviesList(movieName: "")
    }
    
    func loadMoviesList(movieName: String){
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "MovieRating"
            )
            
            request.predicate = NSPredicate(format: "userid == %@ AND ANY movierelationship.name LIKE[c] %@", UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!, "*\(movieName)*")
            let movieRatings = try self.context?.fetch(request) as? [MovieRating]
            
            
            if(movieRatings != nil && movieRatings!.count > 0){
                self.ratingList = movieRatings!
                
            }else{
                self.ratingList = []
            }
            moviesTblView.reloadData()
        }catch{
            print("Movies loading failed")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = ratingList[indexPath.row].movierelationship!
        let movierating = ratingList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "userRatingDetailTblViewCell", for: indexPath) as! UserRatingDetailTableViewCell
        cell.movieImg?.image = CommonData.base64ToImage(movie.coverimage!)
        cell.movieTitleLbl.text = movie.name
        cell.movieGenresLbl.text = movie.genres?.replacingOccurrences(of: ",", with: " |")
        cell.movieRatingLbl.text = "\(String(movierating.rating))/5"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        if let ratedate = movierating.createddate {
            cell.movieRateDateLbl.text = dateFormatter.string(from: ratedate)
        }else{
            cell.movieRateDateLbl.text = ""
        }
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray
        
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = ratingList[indexPath.row].movierelationship{
            selectedMovie = movie
            performSegue(withIdentifier: "ShowMovieRating", sender: self)
        }
                                  
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch(segue.identifier ?? ""){
            
            
        case "ShowMovieRating":
            guard let detailviewcontroller = segue.destination as? RateMovieViewController
            else{
                fatalError("Unexpected destination \(segue.destination)")
            }
            
            detailviewcontroller.selectedMovie = selectedMovie
            detailviewcontroller.context = self.context
            
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
