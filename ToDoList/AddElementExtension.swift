//
//  AddWatchlistElementExtension.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/14/24.
//

import Foundation
import UIKit

extension AddWatchlistTableViewController {
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
}

extension AddMovieTableViewController {
	func addElement(title: String) {
		toReturnMovie.title = title
	}
	
	func addElement(releaseDate: Int) {
		toReturnMovie.releaseYear = releaseDate
	}
	
	func addElement(poster: UIImage) {
		toReturnMovie.poster = poster
	}
	
	func addElement(description: String) {
		toReturnMovie.synopsis = description
	}
}
