//
//  MovieDetailViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var selectedMovie: Movie?
    var movieRatings = [MovieRating]()
    var identifierDetail: String?
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var lblMovieGenre: UILabel!
    @IBOutlet weak var lblMovieRating: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var containerMovieRating: UIStackView!
    @IBOutlet weak var btnMovieAction: UIButton!
    @IBOutlet weak var movieLikeView: UIView!
    @IBOutlet weak var movieLikeImg: UIImageView!
    @IBOutlet weak var userCommentTableView: UITableView!
    
    var ratingImgs = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ident = identifierDetail {
            loadMovieDetails()
            
            if ident == "ShowMovieDetail" {
                btnMovieAction.setTitle("Update Info", for: .normal)
                movieLikeView.isHidden = true
            } else if ident == "UserMovieDetail" {
                btnMovieAction.setTitle("Rate", for: .normal)
                updateMovieFavouriteByUser(movieLiked: getMovieLiked() != nil)
            } else if ident == "ShowUserFavMovieDetail" {
                btnMovieAction.setTitle("Rate", for: .normal)
                updateMovieFavouriteByUser(movieLiked: getMovieLiked() != nil)
            }else{
                btnMovieAction.setTitle("", for: .normal)
            }
            
            loadMovieDetails()
        }
        
        loadComments()
    }
    
    func loadComments(){
        if let movie = selectedMovie {
            
            do{
                let request = NSFetchRequest<NSFetchRequestResult>(
                    entityName: "MovieRating"
                )
                request.predicate = NSPredicate(format: "movieid == %@", movie.id!)
                let moviertings = try self.context?.fetch(request) as? [MovieRating]
                if(moviertings != nil && moviertings!.count > 0){
                    self.movieRatings = moviertings!
                    
                }else{
                    self.movieRatings = []
                }
                userCommentTableView.reloadData()
                 
                
            }catch{
                print("Reload movie details failed.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieRatings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rating = movieRatings[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailTblViewCell", for: indexPath) as! UserCommentTableViewCell
        cell.lblUserComment.text = rating.comment
        cell.lblUserRating.text = "\(String(rating.rating))/5"
        cell.lblUserAndDate.text = "\(rating.userrelationship?.firstname) \(rating.userrelationship?.lastname) - \(dateFormatter.string(from: rating.createddate!))"
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.systemGray
        
        cell.selectedBackgroundView = selectedBackgroundView
        return cell
    }
    
    func loadMovieDetails(){
        if let movie = selectedMovie {
            
            lblMovieTitle.text = movie.name
            lblMovieDesc.text = movie.desc
            lblMovieGenre.text = movie.genres?.replacingOccurrences(of: ",", with: " |")
            lblMovieRating.text = String(movie.rating)
            imgMovie.image = CommonData.base64ToImage(movie.coverimage!)
            
            let ratingImageViews = containerMovieRating.arrangedSubviews.compactMap { $0 as? UIImageView }
            for (i, ratingImg) in ratingImageViews.enumerated() {
                if(i < Int32(movie.useroverallrating)){
                    ratingImg.image = UIImage(named: "YellowStarIcon")
                }else{
                    ratingImg.image = UIImage(named: "FavouriteIcon")
                }
            }
        }
    }
    
    
    @IBAction func clickUpdateMovie(_ sender: Any) {
        if let ident = identifierDetail {
            if ident == "ShowMovieDetail" {
                updateMovieDetails()
            } else if ident == "UserMovieDetail" {
                rateMovie()
            } else if ident == "ShowUserFavMovieDetail" {
                rateMovie()
            }
        }
        
    }
    
    func updateMovieDetails(){
        let storyboard = UIStoryboard(name: "ManageMovie", bundle: nil)
        let manageMovieViewController = storyboard.instantiateViewController(withIdentifier: "ManageMovieView") as! ManageMovieViewController
        manageMovieViewController.selectedMovie = selectedMovie
        manageMovieViewController.identifier = "Update"
        navigationController!.pushViewController(manageMovieViewController, animated: true)
    }
    
    func rateMovie(){
        let storyboard = UIStoryboard(name: "RateMovie", bundle: nil)
        let rateMovieViewController = storyboard.instantiateViewController(withIdentifier: "RateMovieView") as! RateMovieViewController
        rateMovieViewController.selectedMovie = selectedMovie
        rateMovieViewController.context = context
        navigationController!.pushViewController(rateMovieViewController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movie = selectedMovie{
            do{
                let request = NSFetchRequest<NSFetchRequestResult>(
                    entityName: "Movie"
                )
                request.predicate = NSPredicate(format: "id == %@", movie.id!)
                let movies = try self.context?.fetch(request) as? [Movie]
                if(movies != nil && movies!.count > 0){
                    self.selectedMovie = movies![0]
                    loadMovieDetails()
                }
            }catch{
                print("Reload movie details failed.")
            }
        }
    }
    
    func getMovieLiked() -> Favourite?{
        do{
            if let movie = selectedMovie{
                let request = NSFetchRequest<NSFetchRequestResult>(
                    entityName: "Favourite"
                )
                let predicate1 = NSPredicate(format: "userId == %@", UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!)
                let predicate2 = NSPredicate(format: "movieId == %@", movie.id!)
                let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
                request.predicate = compoundPredicate
                request.fetchLimit = 1
                let favourites = try self.context?.fetch(request) as? [Favourite]
                if(favourites != nil && favourites!.count > 0){
                    return favourites![0]
                }
            }
        }catch{
            print("Retrieve movie favourite failed.")
        }
        return nil;
    }
    
    @IBAction func favouriteOnClick(_ sender: Any) {
        do{
            let user = getUser()
            let favouriteMovie = getMovieLiked()
            if(favouriteMovie != nil){
                context.delete(favouriteMovie!)
                updateMovieFavouriteByUser(movieLiked: false)
            }else{
                let newFavouriteMovie = Favourite(id: UUID().uuidString, movieId: selectedMovie!.id!, userId: UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!, insertIntoManagedObjectContext: context)
                selectedMovie?.addToMoviefavouriterelationship(newFavouriteMovie)
                user?.addToFavouriterelationship(newFavouriteMovie)
                updateMovieFavouriteByUser(movieLiked: true)
            }
            try context?.save()
            
        }catch{
            print("Retrieve movie favourite failed.")
        }
    }
    
    func updateMovieFavouriteByUser(movieLiked: Bool){
        if(movieLiked){
            movieLikeImg.image = UIImage(named:"ThumbUpIcon")
        }else{
            movieLikeImg.image = UIImage(named: "ThumbUpIconLine")
        }
    }
    
    func getUser() -> User?{
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "User"
            )
            request.predicate = NSPredicate(format: "id == %@", UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!)
            request.fetchLimit = 1
            let users = try self.context?.fetch(request) as? [User]
            if(users != nil && users!.count > 0){
                return users![0]
            }
        }catch{
            print("Retrieve userß failed.")
        }
        return nil;
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
