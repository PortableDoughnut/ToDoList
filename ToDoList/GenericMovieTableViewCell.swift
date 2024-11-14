//
//  GenericMovieTableViewCell.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/14/24.
//

import UIKit

class GenericMovieTableViewCell: UITableViewCell {
	@IBOutlet weak var posterImage: UIImageView!
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var releaseYearLabel: UILabel!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(with movie: Movie) {
		movieTitleLabel.text = movie.title
		releaseYearLabel.text = movie.releaseYear.description
		posterImage.image = movie.poster
	}

}
