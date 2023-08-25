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
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var lblMovieGenre: UILabel!
    @IBOutlet weak var lblMovieRating: UILabel!
    @IBOutlet weak var lblMovieDesc: UILabel!
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieTitle: UILabel!
    @IBOutlet weak var containerMovieRating: UIStackView!
    
    var ratingImgs = [UIImageView]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMovieDetails()
        

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
        let storyboard = UIStoryboard(name: "ManageMovie", bundle: nil)
        let manageMovieViewController = storyboard.instantiateViewController(withIdentifier: "ManageMovieView") as! ManageMovieViewController
        manageMovieViewController.selectedMovie = selectedMovie
        manageMovieViewController.identifier = "Update"
        navigationController!.pushViewController(manageMovieViewController, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
