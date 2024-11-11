//
//  ToDoTableViewCell.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
	@IBOutlet weak var watchStatusImage: UIImageView!
	@IBOutlet weak var watchDateLabel: UILabel!
	@IBOutlet weak var movieReleaseYearLabel: UILabel!
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var moviePosterImage: UIImageView!
	
	@IBOutlet weak var starOneImage: UIImageView!
	@IBOutlet weak var starTwoImage: UIImageView!
	@IBOutlet weak var starThreeImage: UIImageView!
	@IBOutlet weak var starFourImage: UIImageView!
	@IBOutlet weak var starFiveImage: UIImageView!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ToDoTableViewCell: StarSetterDelegate {
	func didSetStar(starOne: UIImage, starTwo: UIImage, starThree: UIImage, starFour: UIImage, starFive: UIImage) {
		starOneImage.image = starOne
		starTwoImage.image = starTwo
		starThreeImage.image = starThree
		starFourImage.image = starFour
		starFiveImage.image = starFive
	}
	
	
}
