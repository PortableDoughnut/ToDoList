//
//  AddWatchlistTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import UIKit
import Foundation

class AddWatchlistTableViewController: UITableViewController {
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
		
		posterTableViewCell.isHidden = true
		ratingTableViewCell.isHidden = true
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
		case 1:
			addElement(hasWatched: true)
			watchStatusLabel.text = "Watched on"
			ratingTableViewCell.isHidden = false
		default:
			break
		}
		
		tableView.reloadData()
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
	}
	
}
