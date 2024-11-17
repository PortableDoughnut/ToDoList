//
//  ReviewTableViewCell.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/15/24.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
	@IBOutlet weak var movieReviewTextView: UITextView!

	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		// Configure the view for the selected state
	}

	func configure(with toDo: ToDo) {
		movieReviewTextView.text = toDo.review
	}
}
