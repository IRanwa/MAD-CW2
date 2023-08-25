//
//  SearchMovieViewController.swift
//  MAD CW2
//
//  Created by user239258 on 8/26/23.
//

import UIKit
import CoreData

class SearchMovieViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    var moviesList = [Movie]()
    @IBOutlet weak var movieCollectionView: UICollectionView!
    @IBOutlet weak var txtSearchMovie: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        movieCollectionView.dataSource = self
        movieCollectionView.delegate = self
        loadMoviesList(movieName: "")
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
            movieCollectionView.reloadData()
        }catch{
            print("Movies loading failed")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let movie = moviesList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchMovieCollectionViewCell", for: indexPath) as! SearchMovieCollectionViewCell
        cell.movieImg?.image = CommonData.base64ToImage(movie.coverimage!)
        cell.movieNameLbl?.text = movie.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.frame.width
        let itemWidth = (collectionViewWidth - 20) / 2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    @IBAction func searchOnClick(_ sender: Any) {
        loadMoviesList(movieName: txtSearchMovie.text ?? "")
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
