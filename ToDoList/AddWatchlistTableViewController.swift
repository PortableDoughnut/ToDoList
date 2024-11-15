//
//  AddWatchlistTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import UIKit
import Foundation

class AddWatchlistTableViewController: UITableViewController {
	@IBOutlet weak var reviewTextView: UITextView!
	@IBOutlet weak var reviewTableViewCell: UITableViewCell!
	@IBOutlet weak var ratingTableViewCell: UITableViewCell!
	@IBOutlet weak var posterTableViewCell: UITableViewCell!
	@IBOutlet weak var ratingLabel: UILabel!
	@IBOutlet weak var watchStatusLabel: UILabel!
	@IBOutlet weak var ratingSlider: UISlider!
	@IBOutlet weak var chosenMoviePosterImageView: UIImageView!
	
	var toReturnToDo: ToDo?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		do {
			try toReturnToDo = .init(movie: Movie(title: "Fake Movie",
												  description: "This movie so so fake",
												  releaseYear: 2000,
												  poster: UIImage()),
									 watchByDate: Date())
		} catch {
			print("""
Error could not initalize ToDo element:
\(error.localizedDescription)
""")
		}
		setSlider()
		
		reviewTextView.layer.cornerRadius = 10
		reviewTextView.layer.borderWidth = 1
		reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
		reviewTextView.clipsToBounds = true
		
		posterTableViewCell.isHidden = true
		ratingTableViewCell.isHidden = true
		reviewTableViewCell.isHidden = true
		
		tableView.beginUpdates()
		tableView.endUpdates()
		tableView.reloadData()
	}
	
	@IBAction func unwindToAddWatchlist(_ segue: UIStoryboardSegue) {
		guard let source = segue.source as? SelectMovieTableViewController else { return }
		
		addElement(movie: source.selectedMovie!)
		
		chosenMoviePosterImageView.image = toReturnToDo?.poster
		tableView.reloadData()
	}
	
	@IBAction func cancelBarButtonItemPressed(_ sender: UIBarButtonItem) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func watchStatusChanged(_ sender: UISegmentedControl) {
		switch sender.selectedSegmentIndex {
		case 0:
			addElement(hasWatched: false)
			watchStatusLabel.text = "Watch by"
			ratingTableViewCell.isHidden = true
			reviewTableViewCell.isHidden = true
		case 1:
			addElement(hasWatched: true)
			watchStatusLabel.text = "Watched on"
			ratingTableViewCell.isHidden = false
			reviewTableViewCell.isHidden = false
		default:
			break
		}
		
		print("Review cell is \(reviewTableViewCell.isHidden ? "" : "not ") hidden")
		tableView.beginUpdates()
		tableView.endUpdates()
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		let posterIndexPath: IndexPath = .init(row: 2, section: 2)
		let ratingIndexPath: IndexPath = .init(row: 1, section: 3)
		let reviewIndexPath: IndexPath = .init(row: 2, section: 3)
		
		if indexPath == ratingIndexPath {
			return ratingTableViewCell.isHidden ? 0 : UITableView.automaticDimension
		} else if indexPath == reviewIndexPath {
			return reviewTableViewCell.isHidden ? 0 : UITableView.automaticDimension
		} else if indexPath == posterIndexPath {
			return posterTableViewCell.isHidden ? 0 : UITableView.automaticDimension
		}
		
		return UITableView.automaticDimension
	}
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		let step: Float = 0.5
		let roundedValue: Float = round(sender.value / step) * step
		sender.value = roundedValue
		ratingLabel.text = "\(sender.value) / 5 stars"
		
		addElement(rating: Double(sender.value))
	}
	
	@IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
		switch toReturnToDo?.hasWatched {
		case false:
			addElement(watchByDate: sender.date)
		case true:
			addElement(watchedOnDate: sender.date)
		default:
			break
		}
	}
	@IBAction func chooseMovieButtonPressed(_ sender: UIButton) {
		posterTableViewCell.isHidden = false
		
		tableView.beginUpdates()
		tableView.endUpdates()
		tableView.reloadData()
	}
	
	func setSlider() {
		ratingSlider.minimumValue = 0
		ratingSlider.maximumValue = 5
		ratingSlider.value = 2.5
	}
	
	// MARK: - Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
		guard let hasWatchedStatus = toReturnToDo?.hasWatched else { return }
		
		if hasWatchedStatus {
			addElement(review: reviewTextView.text)
		}
	}
	
}
