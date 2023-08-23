//
//  MovieListViewController.swift
//  MAD CW2
//
//  Created by user235755 on 8/15/23.
//

import UIKit
import CoreData

class MovieListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var context:NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return nil
        }
        return appDelegate.stadiaContainer.viewContext;
    }
    var moviesList = [Movie]()
    
    @IBOutlet weak var moviesTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies"
        moviesTblView.delegate = self
        moviesTblView.dataSource = self
        loadMoviesList()
    }
    
    func loadMoviesList(){
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(
                entityName: "Movie"
            )
            let movies = try self.context?.fetch(request) as? [Movie]
            if(movies != nil && movies!.count > 0){
                self.moviesList = movies!
                moviesTblView.reloadData()
            }else{
                _ = Movie(coverimage: CommonData.imageToBase64(image: UIImage(named: "TestMovie")!), desc: "Mission Impossible Image", id: UUID().uuidString, imdblink: "https://www.imdb.com/title/tt9603212/", name: "Mission Impossible", rating: 4.5, useroverallrating: 4.5, youtubelink: "https://www.youtube.com/watch?v=avz06PDqDbM&t=55s&pp=ygUabWlzc2lvbiBpbXBvc3NpYmxlIHRyYWlsZXI%3D", insertIntoManagedObjectContext: context!)
                try context?.save()
            }
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
            return cell
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
