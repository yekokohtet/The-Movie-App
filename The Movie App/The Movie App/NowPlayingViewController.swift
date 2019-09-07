//
//  NowPlayingViewController.swift
//  The Movie App
//
//  Created by Ye Ko Ko Htet on 01/09/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    
    static let identifier = "NowPlayingViewController"
    
    @IBOutlet weak var tableViewMovieList: UITableView!
    
    var movieResponse: MovieResponse = MovieResponse()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=0fb86f37b7f33ed9eaba80c62176f38f&language=en-US&page=1"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, err) in
            DispatchQueue.main.async {
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    self.movieResponse = try
                        decoder.decode(MovieResponse.self, from: data)

                } catch let jsonErr {
                    print(jsonErr)
                }
            }
        }).resume()
        
        tableViewMovieList.separatorStyle = .none
        
        tableViewMovieList.register(UINib(nibName: NowPlayingListItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: NowPlayingListItemTableViewCell.identifier)
        
        tableViewMovieList.dataSource = self
        
        tableViewMovieList.contentInset = UIEdgeInsets(top: 2, left: 0, bottom: 22, right: 0)
    }
    
}

extension NowPlayingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingListItemTableViewCell.identifier, for: indexPath) as! NowPlayingListItemTableViewCell
        cell.movie = movieResponse.results?[indexPath.row]
        return cell
    }
}
