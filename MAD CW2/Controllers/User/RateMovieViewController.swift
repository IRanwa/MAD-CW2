//
//  RateMovieViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/26/23.
//

import UIKit
import CoreData

class RateMovieViewController: UIViewController {

    var selectedMovie: Movie?
    var context: NSManagedObjectContext!
    var ratingIconViews = [UIImageView]()
    var userMarkedRating: Int32 = 0
    
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieGenreLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var ratingView: UIStackView!
    @IBOutlet weak var txtComment: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ratingImageViews = ratingView.arrangedSubviews.compactMap { $0 as? UIImageView }
        for ratingImg in ratingImageViews {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            ratingImg.addGestureRecognizer(tapGesture)
            ratingIconViews.append(ratingImg)
        }
        loadMovie()
    }
    
    func loadMovie(){
        if let movie = selectedMovie{
            movieTitleLbl.text = movie.name
            movieGenreLbl.text = movie.genres!.replacingOccurrences(of: ",", with: " |")
            movieRatingLbl.text = String(describing: movie.rating)
            movieImg.image = CommonData.base64ToImage(movie.coverimage!)
            
            var userRating:Int32 = 0
            let currentRating = getMovieRating()
            if(currentRating != nil){
                userRating = currentRating!.rating
                txtComment.text = currentRating?.comment
            }
            updateRating(userRating: userRating)
        }
    }
    
    func updateRating(userRating : Int32){
        for (i, ratingImg) in ratingIconViews.enumerated() {
            if(i < userRating){
                ratingImg.image = UIImage(named: "YellowStarIcon")
            }else{
                ratingImg.image = UIImage(named: "FavouriteIcon")
            }
        }
    }
    
    func getMovieRating() -> MovieRating?{
        do{
            if let movie = selectedMovie{
                let request = NSFetchRequest<NSFetchRequestResult>(
                    entityName: "MovieRating"
                )
                let predicate1 = NSPredicate(format: "userid == %@", UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!)
                let predicate2 = NSPredicate(format: "movieid == %@", movie.id!)
                let compoundPredicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1, predicate2])
                request.predicate = compoundPredicate
                request.fetchLimit = 1
                let movieRating = try self.context?.fetch(request) as? [MovieRating]
                if(movieRating != nil && movieRating!.count > 0){
                    return movieRating![0]
                }
            }
        }catch{
            print("Retrieve movie movie rating failed.")
        }
        return nil;
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let index = ratingIconViews.firstIndex(of: gesture.view as! UIImageView) else { return }
        userMarkedRating = Int32(index + 1)
        updateRating(userRating: userMarkedRating)
    }
    
    @IBAction func submitOnClick(_ sender: Any) {
        do{
            if let user = getUser(){
                var movieRating = getMovieRating()
                if(movieRating == nil){
                    _ = MovieRating(comment: txtComment.text, id: UUID().uuidString, movieid: selectedMovie!.id!, rating: userMarkedRating, userid: UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!, createddate: Date(), movierelationship: selectedMovie!, userrelationship: user, insertIntoManagedObjectContext: context)
                }else{
                    movieRating?.createddate = Date()
                    movieRating?.rating = userMarkedRating
                    movieRating?.comment = txtComment.text
                }
                try context.save()
                updateMovieUserOverrallRating()
                navigationController?.popViewController(animated: true)
            }
        }catch{
            print("Movie rating save failed.")
        }
    }
    
    func updateMovieUserOverrallRating(){
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Movie"
            )
            request.predicate = NSPredicate(format: "id == %@", selectedMovie!.id!)
            request.fetchLimit = 1
            let movies = try self.context?.fetch(request) as? [Movie]
            if(movies != nil && movies!.count > 0){
                var movie = movies![0]
                var overrallRating: Int32 = 0
                if let ratings = movie.movieratingrelationship?.array as? [MovieRating]{
                    for rating in ratings {
                        if(overrallRating == 0){
                            overrallRating = rating.rating
                        }else{
                            overrallRating = (overrallRating+rating.rating)/2
                        }
                    }
                    movie.useroverallrating = overrallRating
                    try context.save()
                }
                
            }
        }catch{
            print("Update movie user overrall rating failed.")
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
            print("User fetch failed")
        }
        return nil
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
