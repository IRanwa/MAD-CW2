//
//  MovieDetailViewController.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//

import UIKit
import CoreData

class MovieDetailViewController: UIViewController {

    var selectedMovie: Movie?
    var identifier: String?
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var lblMovieGenre: UILabel!
    @IBOutlet weak var lblMovieRating: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var containerMovieRating: UIStackView!
    @IBOutlet weak var btnMovieAction: UIButton!
    @IBOutlet weak var updateAndRateButton: UIButton!
    @IBOutlet weak var movieLikeView: UIView!
    @IBOutlet weak var movieLikeImg: UIImageView!
    
    var ratingImgs = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ident = identifier {
            loadMovieDetails()
            
            if ident == "ShowMovieDetail" {
                btnMovieAction.setTitle("Update Info", for: <#T##UIControl.State#>)
            } else if ident == "UserMovieDetail" {
                btnMovieAction.setTitle("Rate", for: <#T##UIControl.State#>)
            } else if ident == "ShowUserFavMovieDetail" {
                btnMovieAction.setTitle("Rate", for: <#T##UIControl.State#>)
            }
            
        loadMovieDetails()
        if(UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userType)) == String(describing: Enums.UserType.standard)){
            updateAndRateButton.titleLabel?.text = "Rate Movie"
            updateMovieFavouriteByUser(movieLiked: getMovieLiked() != nil)
        }else{
            movieLikeView.isHidden = true
        }
        
        // Do any additional setup after loading the view.
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
        if let ident = identifier {
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
            let favouriteMovie = getMovieLiked()
            if(favouriteMovie != nil){
                context.delete(favouriteMovie!)
            }else{
                _ = Favourite(id: UUID().uuidString, movieId: selectedMovie!.id!, userId: UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!, insertIntoManagedObjectContext: context)
                
            }
            try context?.save()
            updateMovieFavouriteByUser(movieLiked: favouriteMovie == nil)
        }catch{
            print("Retrieve movie favourite failed.")
        }
    }
    
    func updateMovieFavouriteByUser(movieLiked: Bool){
        if(movieLiked){
            movieLikeImg.image = UIImage(systemName: "hand.thumbsup.fill")
        }else{
            movieLikeImg.image = UIImage(systemName: "hand.thumbsup")
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
