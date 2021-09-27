//
//  TrailerViewController.swift
//  Flix
//
//  Created by Sayed Jahed Hussini on 9/27/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    var movieId: Any!
    var videoList = [[String:Any]] ()
    
    override func viewDidLoad() {
    
      super.viewDidLoad()
    
        let videosUrl = URL(string: "https://api.themoviedb.org/3/movie/\(movieId!)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US&page=1")!
        let request = URLRequest(url: videosUrl, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                self.videoList = dataDictionary["results"] as! [[String:Any]]

                let link = self.getTrailerLink(self.videoList)
                
                let myURL = URL(string: String(link))
                let myRequest = URLRequest(url: myURL!)
                self.webView.load(myRequest)
                
                
                self.webView.reload()

             }
        }
        task.resume()
        
        //get a list of videos
        

    
    }
    
    override func loadView() {
    
      let webConfiguration = WKWebViewConfiguration()
      webView = WKWebView(frame: .zero, configuration: webConfiguration)
      webView.uiDelegate = self
      view = webView
    }
    
    func getTrailerLink(_ link: [[String:Any]] ) -> String {
        var trailerLink: String = ""
        if link != nil {
            
            for l in link {
                if l["type"] as! String == "Trailer" && l["site"] as! String == "YouTube" {
                    let key = l["key"] as! String
                    trailerLink = "https://www.youtube.com/watch?v=\(key)"
                    break
                }
            }
        }
        
        return trailerLink
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
