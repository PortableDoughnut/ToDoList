//
//  AddMovieTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import UIKit
import Foundation

class AddMovieTableViewController: UITableViewController {
	@IBOutlet weak var releaseYearPicker: UIPickerView!
	@IBOutlet weak var movieDescriptionTextView: UITextView!
	
	var toReturnMovie: Movie?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		movieDescriptionTextView.layer.cornerRadius = 10
		movieDescriptionTextView.layer.borderWidth = 1
		movieDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
		movieDescriptionTextView.clipsToBounds = true
		
		releaseYearPicker.dataSource = self
		releaseYearPicker.delegate = self
    }
	
	
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
		guard segue.destination is ToDoTableViewController else { return }
        // Pass the selected object to the new view controller.
		
		toReturnMovie?.description = movieDescriptionTextView.text
		Movie.movies.append(toReturnMovie!)
    }
	
	@IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
		dismiss(animated: true)
	}
	
}

extension AddMovieTableViewController: UIPickerViewDataSource, UIPickerViewDelegate {
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		1
	}
	
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		let calendar = Calendar.current
		
		let currentYear = calendar.component(.year, from: Date()) + 1
		
		return currentYear - 1888
	}
	
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		let calendar = Calendar.current
		
		let currentYear = calendar.component(.year, from: Date())
		
		return "\(currentYear - row)"
	}
}
