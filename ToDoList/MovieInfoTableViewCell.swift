//
//  MovieInfoTableViewCell.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/15/24.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
	@IBOutlet weak var moviePosterImageView: UIImageView!
	@IBOutlet weak var watchDateLabel: UILabel!
	@IBOutlet weak var releaseYearLabel: UILabel!
	@IBOutlet weak var movieTitleLabel: UILabel!
	
	@IBOutlet weak var starFiveUIImage: UIImageView!
	@IBOutlet weak var starFourUIImage: UIImageView!
	@IBOutlet weak var starThreeUIImage: UIImageView!
	@IBOutlet weak var starTwoUIImage: UIImageView!
	@IBOutlet weak var starOneUIImage: UIImageView!
	
	let starController: StarLogicController = .init()
	
    override func awakeFromNib() {
        super.awakeFromNib()
        
		starController.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func configure(with toDo: ToDo) {
		movieTitleLabel.text = toDo.title
		moviePosterImageView.image = toDo.poster
		watchDateLabel.text = toDo.hasWatched ? "Watched on \(toDo.watchedOnDate?.formatted(date: .long, time: .omitted) ?? "")" : "Watch by \(toDo.watchByDate?.formatted(date: .long, time: .omitted) ?? "")"
		releaseYearLabel.text = "\(toDo.releaseYear)"
		starController.setStar(toDo, starArray: [starOneUIImage.image ?? UIImage(),
												 starTwoUIImage.image ?? UIImage(),
												 starThreeUIImage.image ?? UIImage(),
												 starFourUIImage.image ?? UIImage(),
												 starFiveUIImage.image ?? UIImage()])
	}

}

extension MovieInfoTableViewCell: StarSetterDelegate {
	func didSetStar(starOne: UIImage, starTwo: UIImage, starThree: UIImage, starFour: UIImage, starFive: UIImage) {
		starOneUIImage.image = starOne
		starTwoUIImage.image = starTwo
		starThreeUIImage.image = starThree
		starFourUIImage.image = starFour
		starFiveUIImage.image = starFive
	}
}
