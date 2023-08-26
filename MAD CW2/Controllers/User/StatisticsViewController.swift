//
//  StatisticsViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/26/23.
//

import UIKit
import CoreData

class StatisticsViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    var topGenres: [String: Double] = [:]
    var selectedMovie : Movie?
    
    var firstGenreMovies = [Movie]()
    var secondGenreMovies = [Movie]()
    var thirdGenreMovies = [Movie]()
    
    @IBOutlet weak var genreFirstView: UIStackView!
    @IBOutlet weak var genreSecondView: UIStackView!
    @IBOutlet weak var genreThirdView: UIStackView!
    
    //First genre view
    @IBOutlet weak var genreNameFirst: UILabel!
    @IBOutlet weak var genreProgressFirst: UIProgressView!
    @IBOutlet weak var genreProgressLblFirst: UILabel!
    @IBOutlet weak var firstGenreMoviesListView: UIStackView!
    
    //Second Genre View
    @IBOutlet weak var genreNameSecond: UILabel!
    @IBOutlet weak var genreProgressSecond: UIProgressView!
    @IBOutlet weak var genreProgressLblSecond: UILabel!
    @IBOutlet weak var secondGenreMoviesListView: UIStackView!
    
    //Third Genre View
    @IBOutlet weak var genreNameThird: UILabel!
    @IBOutlet weak var genreProgressThird: UIProgressView!
    @IBOutlet weak var genreProgressLblThird: UILabel!
    @IBOutlet weak var thirdGenreMoviesListView: UIStackView!
    
    @IBOutlet weak var firstGenreLbl: UILabel!
    @IBOutlet weak var firstGenreCollectionView: UICollectionView!
    
    @IBOutlet weak var secondGenreLbl: UILabel!
    @IBOutlet weak var secondGenreCollectionView: UICollectionView!
    
    @IBOutlet weak var thirdGenreLbl: UILabel!
    @IBOutlet weak var thirdGenreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTopgenres()
        
        firstGenreCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        firstGenreCollectionView.delegate = self
        firstGenreCollectionView.dataSource = self
        
        secondGenreCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        secondGenreCollectionView.delegate = self
        secondGenreCollectionView.dataSource = self
        
        thirdGenreCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        thirdGenreCollectionView.delegate = self
        thirdGenreCollectionView.dataSource = self
    }
    
    func configureTopgenres(){
        for genre in CommonData.genres{
            topGenres[genre] = 0
        }
        loadTopGenres()
        renderTopGenres()
    }
    
    func loadTopGenres(){
        
        var topGenresRating : [StatisticsModel] = []
        do{
            var request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "MovieRating"
            )
            request.predicate = NSPredicate(format: "userid == %@", UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!)
            let movieRatings = try self.context?.fetch(request) as? [MovieRating]
            if(movieRatings != nil && movieRatings!.count > 0){
                
                for rating in movieRatings!{
                    let genres = rating.movierelationship?.genres!.components(separatedBy: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } as! [String]
                    for genre in genres{
                        
                        topGenresRating.append(StatisticsModel(genre: genre, score: Double(rating.rating) / Double(5.0)))
                        
                        /*if(topGenres[genre]! == 0){
                            topGenres[genre] = Double(rating.rating) / 5
                        }else{
                            topGenres[genre] = (topGenres[genre]! + Double(rating.rating/5))/2
                        }*/
                    }
                }
            }
            
            request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Favourite"
            )
            request.predicate = NSPredicate(format: "userId == %@", UserDefaults.standard.string(forKey: String(describing: Enums.UserDefaultKeys.userId))!)
            let favourites = try self.context?.fetch(request) as? [Favourite]
            if(favourites != nil && favourites!.count > 0){
                for favourite in favourites!{
                    let genres =
                    favourite.movierelatioship?.genres!.components(separatedBy: ",")
                        .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) } as! [String]
                    for genre in genres{
                        topGenresRating.append(StatisticsModel(genre: genre, score: 1))
                        /*if(topGenres[genre]! == 0){
                            topGenres[genre] = 1
                        }else{
                            topGenres[genre] = (topGenres[genre]! + 1)/2
                        }*/
                    }
                }
            }
            
            var genreToTotalScore: [String: Double] = [:]
            for toprating in topGenresRating {
                if let currentTotalScore = genreToTotalScore[toprating.genre] {
                    genreToTotalScore[toprating.genre] = currentTotalScore + toprating.score
                } else {
                    genreToTotalScore[toprating.genre] = toprating.score
                }
            }
            
            
            let sortedGenres = genreToTotalScore.sorted { $0.value > $1.value }
            print(sortedGenres)
            let topThree = Array(sortedGenres.prefix(3))
            let topThreeGenres = Dictionary(uniqueKeysWithValues: topThree)
            
            var totalGenreValue = 0.0
            for genre in topThreeGenres{
                totalGenreValue += genre.value
            }
            for genre in topThreeGenres{
                topGenres[genre.key] = (genre.value/totalGenreValue)
            }
            
        }catch{
            print("Movies top genres loading failed")
        }
    }
    
    func renderTopGenres(){
        let sortedGenres = topGenres.sorted { $0.value > $1.value }
        if(sortedGenres.count > 0 && sortedGenres[0].value > 0.0){
            genreNameFirst.text = sortedGenres[0].key
            genreProgressFirst.progress = Float(sortedGenres[0].value)
            genreProgressLblFirst.text = "\(String(format: "%.2f", sortedGenres[0].value*100))%"
            getFirstGenreMovies(genre: sortedGenres[0].key)
            genreFirstView.isHidden = false
            firstGenreMoviesListView.isHidden = false
        }else{
            genreFirstView.isHidden = true
            firstGenreMoviesListView.isHidden = true
        }
        
        if(sortedGenres.count > 1 && sortedGenres[1].value > 0.0){
            genreNameSecond.text = sortedGenres[1].key
            genreProgressSecond.progress = Float(sortedGenres[1].value)
            genreProgressLblSecond.text = "\(String(format: "%.2f", sortedGenres[1].value*100))%"
            getSecondGenreMovies(genre: sortedGenres[1].key)
            genreSecondView.isHidden = false
            secondGenreMoviesListView.isHidden = false
        }else{
            genreSecondView.isHidden = true
            secondGenreMoviesListView.isHidden = true
        }
        
        if(sortedGenres.count > 2 && sortedGenres[2].value > 0.0){
            genreNameThird.text = sortedGenres[2].key
            genreProgressThird.progress = Float(sortedGenres[2].value)
            genreProgressLblThird.text = "\(String(format: "%.2f", sortedGenres[2].value*100))%"
            getThirdGenreMovies(genre: sortedGenres[2].key)
            genreThirdView.isHidden = false
            thirdGenreMoviesListView.isHidden = false
        }else{
            genreThirdView.isHidden = true
            thirdGenreMoviesListView.isHidden = true
        }
    }
    
    func getFirstGenreMovies(genre: String){
        firstGenreLbl.text = genre
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Movie"
            )
            request.predicate = NSPredicate(format: "genres Like[c] %@", "*\(genre)*")
            let sortDescriptor = NSSortDescriptor(key: "useroverallrating", ascending: false)
                    request.sortDescriptors = [sortDescriptor]
            request.fetchLimit = 3
            let movies = try self.context?.fetch(request) as? [Movie]
            if(movies != nil && movies!.count > 0){
                firstGenreMovies = movies!
                firstGenreCollectionView.reloadData()
            }
        }catch{
            print("First genre movies fetch failed.")
        }
    }
    
    func getSecondGenreMovies(genre: String){
        secondGenreLbl.text = genre
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Movie"
            )
            request.predicate = NSPredicate(format: "genres Like[c] %@", "*\(genre)*")
            let sortDescriptor = NSSortDescriptor(key: "useroverallrating", ascending: false)
                    request.sortDescriptors = [sortDescriptor]
            request.fetchLimit = 3
            let movies = try self.context?.fetch(request) as? [Movie]
            if(movies != nil && movies!.count > 0){
                secondGenreMovies = movies!
                secondGenreCollectionView.reloadData()
            }
        }catch{
            print("Second genre movies fetch failed.")
        }
    }
    
    func getThirdGenreMovies(genre: String){
        thirdGenreLbl.text = genre
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Movie"
            )
            request.predicate = NSPredicate(format: "genres Like[c] %@", "*\(genre)*")
            let sortDescriptor = NSSortDescriptor(key: "useroverallrating", ascending: false)
                    request.sortDescriptors = [sortDescriptor]
            request.fetchLimit = 3
            let movies = try self.context?.fetch(request) as? [Movie]
            if(movies != nil && movies!.count > 0){
                thirdGenreMovies = movies!
                thirdGenreCollectionView.reloadData()
            }
        }catch{
            print("Third genre movies fetch failed.")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTopgenres()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == firstGenreCollectionView){
            return firstGenreMovies.count
        }else if(collectionView == secondGenreCollectionView){
            return secondGenreMovies.count
        }else if(collectionView == thirdGenreCollectionView){
            return thirdGenreMovies.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == firstGenreCollectionView){
            let movie = firstGenreMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FirstGenreCollectionViewCell", for: indexPath) as! FirstGenreMoviesCollectionViewCell
            cell.movieImg?.image = CommonData.base64ToImage(movie.coverimage!)
            cell.movieName?.text = movie.name
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor.systemGray
            
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        }else if(collectionView == secondGenreCollectionView){
            let movie = secondGenreMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondGenreCollectionViewCell", for: indexPath) as! SecondGenreMoviesCollectionViewCell
            cell.movieImg?.image = CommonData.base64ToImage(movie.coverimage!)
            cell.movieName?.text = movie.name
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor.systemGray
            
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        }else if(collectionView == thirdGenreCollectionView){
            let movie = thirdGenreMovies[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ThirdGenreCollectionViewCell", for: indexPath) as! ThirdGenreMoviesCollectionViewCell
            cell.movieImg?.image = CommonData.base64ToImage(movie.coverimage!)
            cell.movieName?.text = movie.name
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = UIColor.systemGray
            
            cell.selectedBackgroundView = selectedBackgroundView
            return cell
        }
        return FirstGenreMoviesCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 20) / 3
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(collectionView == firstGenreCollectionView){
            selectedMovie = firstGenreMovies[indexPath.item]
        }
        else if(collectionView == secondGenreCollectionView){
            selectedMovie = secondGenreMovies[indexPath.item]
        }
        else if(collectionView == thirdGenreCollectionView){
            selectedMovie = thirdGenreMovies[indexPath.item]
        }
        performSegue(withIdentifier: "UserMovieDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier ?? ""){
            
            
        case "UserMovieDetail":
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
