//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by Sayed Jahed Hussini on 9/24/21.
//

import UIKit
import AlamofireImage

class MovieGridDetailsViewController: UIViewController {

    var movie: [String:Any]!
    
    @IBOutlet weak var backdropView: UIImageView!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        dateLabel.text = movie["release_date"] as? String
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let baseUrlBackdrop = "https://image.tmdb.org/t/p/w780"
        
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string: baseUrl + posterPath)
        let backdropUrl = URL(string: baseUrlBackdrop + posterPath )

        posterView.af.setImage(withURL: posterUrl!)
        backdropView.af.setImage(withURL: backdropUrl!)
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