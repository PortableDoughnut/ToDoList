//
//  MovieEditTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/16/24.
//

import UIKit

class MovieEditTableViewController: UITableViewController {
	@IBOutlet weak var datePicker: UIDatePicker!
	@IBOutlet weak var ratingSlider: UISlider!
	@IBOutlet weak var ratingLabel: UILabel!
	@IBOutlet weak var reviewTextView: UITextView!
	@IBOutlet weak var releaseYearLabel: UILabel!
	@IBOutlet weak var movieTitleLabel: UILabel!
	@IBOutlet weak var posterImageView: UIImageView!
	
	var toDo: ToDo?
	var isSaving: Bool = false
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		movieTitleLabel.text = toDo?.title
		releaseYearLabel.text = "\(toDo!.releaseYear)"
		posterImageView.image = toDo?.poster
		
		reviewTextView.text = toDo?.review
		reviewTextView.layer.cornerRadius = 10
		reviewTextView.layer.borderWidth = 1
		reviewTextView.layer.borderColor = UIColor.lightGray.cgColor
		reviewTextView.clipsToBounds = true
		
		ratingSlider.minimumValue = 0
		ratingSlider.maximumValue = 5
		ratingSlider.value = Float(toDo?.rating ?? 2.5)
		
		datePicker.date = toDo?.watchedOnDate ?? Date()
		
		toDo?.hasWatched = true
	}
	
	@IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
		toDo?.watchedOnDate = sender.date
	}
	
	@IBAction func sliderVlaueChanged(_ sender: UISlider) {
		let step: Float = 0.5
		let roundedValue: Float = round(sender.value / step) * step
		sender.value = roundedValue
		ratingLabel.text = "\(sender.value) / 5 stars"
		
		toDo?.rating = Double(sender.value)
	}
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if isSaving {
			guard let destination = segue.destination as? ToDoTableViewController,
				  let toDo = toDo,
				  let index = destination.toDos.firstIndex(of: toDo) else {
				print("Error: Unable to save changes.")
				return
			}
			
			var toDoMutable: ToDo = toDo
			
			toDoMutable.hasWatched = true
			toDoMutable.review = reviewTextView.text
			
			destination.toDos[index] = toDo
		}
	}
	
	// Pass the selected object to the new view controller.
	@IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
		isSaving = true
		toDo?.review = reviewTextView.text
		performSegue(withIdentifier: "unwindEditDone", sender: sender)
	}
}
