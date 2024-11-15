//
//  AddWatchlistElementExtension.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/14/24.
//

import Foundation

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
