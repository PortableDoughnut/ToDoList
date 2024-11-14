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
	
	let starLogic: StarLogicController = StarLogicController()
	
    override func awakeFromNib() {
        super.awakeFromNib()
		starLogic.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func configure(with toDo: ToDo) {
		moviePosterImage.image = toDo.movie.poster
		movieTitleLabel.text = toDo.movie.title
		movieReleaseYearLabel.text = toDo.movie.releaseYear.description
		switch toDo.hasWatched {
			case true:
			watchStatusImage.image = UIImage(systemName: "checkmark.circle.fill")
			watchDateLabel.text = toDo.watchedOnDate?.formatted(
				.dateTime
					.month(.abbreviated)
					.day()
					.year(.defaultDigits))
			?? "No Date Set"
		case false:
			let formattedWatchByDate: String = toDo.watchByDate?
				.formatted(.dateTime
					.month(.abbreviated)
					.day()
					.year(.defaultDigits))
			?? "No Date Set"
			
			watchStatusImage.image = UIImage()
			watchDateLabel.text = "Watch by \(formattedWatchByDate)"
		}
		starLogic.setStar(toDo, starArray: [starOneImage.image ?? UIImage(),
											starTwoImage.image ?? UIImage(),
											starThreeImage.image ?? UIImage(),
											starFourImage.image ?? UIImage(),
											starFiveImage.image ?? UIImage()])
		
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
