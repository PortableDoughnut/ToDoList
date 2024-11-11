//
//  ToDo.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import Foundation
import UIKit

struct ToDo {
	var id: UUID
	var movie: Movie
	var hasWatched: Bool
	var watchedOnDate: Date?
	var review: String
	var rating: Double
	var watchByDate: Date
}

extension ToDo: Equatable {
	static func == (lhs: ToDo, rhs: ToDo) -> Bool {
		return lhs.id == rhs.id
	}
}

extension ToDo: Comparable {
	static func < (lhs: ToDo, rhs: ToDo) -> Bool {
		if lhs.watchByDate > Date() {
			if let lhsWatchByDate = lhs.watchedOnDate, let rhsWatchByDate = rhs.watchedOnDate {
				return lhsWatchByDate < rhsWatchByDate
			} else {
				return lhs.movie.title < rhs.movie.title
			}
		} else {
			return lhs.watchByDate < rhs.watchByDate
		}
	}
}
