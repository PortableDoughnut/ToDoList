//
//  AddMovieTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import UIKit
import Foundation

class AddMovieTableViewController: UITableViewController {
	@IBOutlet weak var posterImageView: UIImageView!
	@IBOutlet weak var releaseYearPicker: UIPickerView!
	@IBOutlet weak var movieDescriptionTextView: UITextView!
	let imagePicker: UIImagePickerController = .init()
	
	var toReturnMovie: Movie = .init(
		title: "Fake movie",
		description: "It's fake",
		releaseYear: 2000,
		poster: UIImage())
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		imagePicker.delegate = self
		
		movieDescriptionTextView.layer.cornerRadius = 10
		movieDescriptionTextView.layer.borderWidth = 1
		movieDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
		movieDescriptionTextView.clipsToBounds = true
		
		releaseYearPicker.dataSource = self
		releaseYearPicker.delegate = self
    }
	
	@IBAction func movieTitleEditingDidEnd(_ sender: UITextField) {
		addElement(title: sender.text ?? "")
	}
	
	@IBAction func choosePosterButtonPressed(_ sender: UIButton) {
		choosePoster()
	}
	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
		guard segue.destination is ToDoTableViewController else { return }
        // Pass the selected object to the new view controller.
		
		toReturnMovie.synopsis = movieDescriptionTextView.text
		Movie.movies.append(toReturnMovie)
		Movie.saveMovies(Movie.movies)
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
	
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		let calendar = Calendar.current
		
		let currentYear = calendar.component(.year, from: Date())
		
		addElement(releaseDate: currentYear - row)
	}
}

extension AddMovieTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func choosePoster() {
		let imageAlertController: UIAlertController = .init(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
		let cancelAction: UIAlertAction = .init(title: "Cancel", style: .cancel, handler: nil)
		imageAlertController.addAction(cancelAction)
		
		if UIImagePickerController.isSourceTypeAvailable(.camera) {
			let cameraAction: UIAlertAction = .init(title: "Camera", style: .default, handler: { _ in
				self.imagePicker.sourceType = .camera
				self.present(self.imagePicker, animated: true, completion: nil)
			})
			imageAlertController.addAction(cameraAction)
		}
		
		if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
			let photoLibraryAction: UIAlertAction = .init(title: "Photo Library", style: .default, handler: { _ in
				self.imagePicker.sourceType = .photoLibrary
				self.present(self.imagePicker, animated: true, completion: nil)
			})
			imageAlertController.addAction(photoLibraryAction)
			
			present(imageAlertController, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		guard let image: UIImage = info[.originalImage] as? UIImage else { return }
		posterImageView.image = image
		addElement(poster: image)
		dismiss(animated: true, completion: nil)
	}
}
