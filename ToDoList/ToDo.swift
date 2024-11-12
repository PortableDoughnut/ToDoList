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
	var review: String?
	var rating: Double?
	var watchByDate: Date?
	
	var title: String {
		movie.title
	}
	var poster: UIImage {
		movie.poster
	}
	var releaseYear: Int {
		movie.releaseYear
	}
	var description: String {
		movie.description
	}
	
	init(id: UUID, movie: Movie, hasWatched: Bool, watchedOnDate: Date?, review: String?, rating: Double?, watchByDate: Date) {
		self.id = id
		self.movie = movie
		self.hasWatched = hasWatched
		self.watchedOnDate = watchedOnDate
		self.review = review
		self.rating = rating
		self.watchByDate = watchByDate
	}
	init(movie: Movie, watchByDate: Date) throws {
		id = UUID()
		self.movie = movie
		hasWatched = false
		watchedOnDate = nil
		review = nil
		rating = nil
		self.watchByDate = watchByDate
	}
	init(movie: Movie, hasWatched: Bool, watchedOnDate: Date?, review: String?, rating: Double?, watchByDate: Date) {
		id = UUID()
		self.movie = movie
		self.hasWatched = hasWatched
		self.watchedOnDate = watchedOnDate
		self.review = review
		self.rating = rating
		self.watchByDate = watchByDate
	}
	init(movie: Movie, hasWatched: Bool, watchedOnDate: Date?, review: String?, rating: Double?) {
		id = UUID()
		self.movie = movie
		self.hasWatched = hasWatched
		self.watchedOnDate = watchedOnDate
		self.review = review
		self.rating = rating
		watchByDate = nil
	}
}

extension ToDo: Equatable {
	static func == (lhs: ToDo, rhs: ToDo) -> Bool {
		return lhs.id == rhs.id
	}
}

extension ToDo: Comparable {
	static func < (lhs: ToDo, rhs: ToDo) -> Bool {
		if let lhsWatchByDate = lhs.watchByDate,
		   let rhsWatchByDate = rhs.watchByDate	{
			if lhsWatchByDate > Date() {
				if let lhsWatchByDate = lhs.watchedOnDate, let rhsWatchByDate = rhs.watchedOnDate {
					return lhsWatchByDate < rhsWatchByDate
				} else {
					return lhs.movie.title < rhs.movie.title
				}
			} else {
				return lhsWatchByDate < rhsWatchByDate
			}
		} else	{
			return lhs.movie.title < rhs.movie.title
		}
	}
	
}

func setupToDoList() -> [ToDo] {
	do {
		guard let funnyPages: Movie = movies.first(where: {
			$0.title == "Funny Pages"	}),
			  let house: Movie = movies.first(where: {
				  $0.title == "House"	}),
			  let howToSucceed: Movie = movies.first(where: {	$0.title ==
				  "How to Succeed in Business Without Really Trying"	}),
			  let laLaLand: Movie = movies.first(where: {	$0.title ==
				  "La La Land"	}),
			  let megalopolis: Movie = movies.first(where: {	$0.title == "Megaloplis"	}),
			  let omniLoop: Movie = movies.first(where: {	$0.title ==
				  "Omni Loop"	}),
			  let theApartment: Movie = movies.first(where: {	$0.title ==
				  "The Apartment"	})
		else {
			print("Error getting movies")
			return []
		}
		return try [
			ToDo(movie: funnyPages,
				 watchByDate: Calendar.current.date(from: DateComponents(
					year: 2024,
					month: 11,
					day: 28,
					hour: 00,
					minute: 00,
					second: 00))!),
			try ToDo(movie: house,
					 watchByDate: Calendar.current.date(from: DateComponents(
						year: 2025,
						month: 10,
						day: 31,
						hour: 00,
						minute: 00,
						second: 00))!),
			try ToDo(movie: howToSucceed,
					 watchByDate: Calendar.current.date(from: DateComponents(
						year: 2025,
						month: 7,
						day: 4,
						hour: 00,
						minute: 00,
						second: 00))!),
			try ToDo(movie: laLaLand,
					 watchByDate: Calendar.current.date(from: DateComponents(
						year: 2025,
						month: 3,
						day: 2,
						hour: 00,
						minute: 00,
						second: 00))!),
			try ToDo(movie: megalopolis,
					 watchByDate: Calendar.current.date(from: DateComponents(
						year: 2025,
						month: 2,
						day: 5,
						hour: 00,
						minute: 00,
						second: 00
					 ))!),
			try ToDo(movie: omniLoop,
					 watchByDate: Calendar.current.date(from: DateComponents(
						year: 2025,
						month: 9,
						day: 8,
						hour: 00,
						minute: 00,
						second: 00))!),
			try ToDo(movie: theApartment,
					 watchByDate: Calendar.current.date(from: DateComponents(
						year: 2024,
						month: 12,
						day: 31,
						hour: 24,
						minute: 59,
						second: 59
					 ))!)
		]
	} catch {
		print("""
Error setting up Default ToDoList:
\(error)
""")
		return []
	}
}

var toDoList: [ToDo] = setupToDoList()
