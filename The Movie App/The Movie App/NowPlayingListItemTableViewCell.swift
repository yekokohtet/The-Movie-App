//
//  NowPlayingListItemTableViewCell.swift
//  The Movie App
//
//  Created by Ye Ko Ko Htet on 01/09/2019.
//  Copyright © 2019 Ye Ko Ko Htet. All rights reserved.
//

import UIKit
import SDWebImage

class NowPlayingListItemTableViewCell: UITableViewCell {
    
    static let identifier = "NowPlayingListItemTableViewCell"
    
    @IBOutlet weak var ivPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleasedDate: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    
    var movie: MovieVO? {
        didSet {
            if let movie = movie {
                
                let posterString = "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")"
                
                ivPoster.sd_setImage(with: URL(string: posterString), placeholderImage: UIImage(named: "placeholder"))
                lblTitle.text = movie.title
                lblReleasedDate.text = movie.releaseDate
                lblOverview.text = movie.overview
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
