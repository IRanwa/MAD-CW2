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
    
    @IBOutlet weak var movieTitleLbl: UILabel!
    @IBOutlet weak var movieGenreLbl: UILabel!
    @IBOutlet weak var movieRatingLbl: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadMovie()
    }
    
    func loadMovie(){
        if let movie = selectedMovie{
            movieTitleLbl.text = movie.name
            movieGenreLbl.text = movie.genres!.replacingOccurrences(of: ",", with: " |")
            movieRatingLbl.text = String(describing: movie.rating)
            movieImg.image = CommonData.base64ToImage(movie.coverimage!)
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
