//
//  AddWatchlistTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import UIKit

class AddWatchlistTableViewController: UITableViewController {
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
	}
	
	@IBAction func unwindToAddWatchlist(_ segue: UIStoryboardSegue) {
		guard let source = segue.source as? SelectMovieTableViewController else { return }
		
		addElement(movie: source.selectedMovie!)
		
		chosenMoviePosterImageView.image = toReturnToDo?.poster
		tableView.reloadData()
	}
	
	func addElement(movie: Movie) {
		toReturnToDo?.movie = movie
	}
	
	func addElement(watchByDate: Date) {
		toReturnToDo?.watchByDate = watchByDate
	}
	
	func addElement(hasWatched: Bool) {
		toReturnToDo?.hasWatched = hasWatched
	}
	
	func addElement(watchedOnDate: Date) {
		toReturnToDo!.watchedOnDate = watchedOnDate
	}
	
	func addElement(review: String) {
		toReturnToDo?.review = review
	}
	
	func addElement(rating: Double) {
		toReturnToDo?.rating = rating
	}
	
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destination.
		// Pass the selected object to the new view controller.
	}
	
}
