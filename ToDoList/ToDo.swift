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
	var synopsis: String {
		movie.synopsis
	}
	
	static func loadToDos() -> [ToDo]? {
		guard let codedToDos = try? Data(contentsOf: archiveURL) else {	return nil	}
		let propertyListDecoder: PropertyListDecoder = .init()
		do	{
			return try? propertyListDecoder.decode(Array<ToDo>.self, from: codedToDos)
		}
		}
	
	static func saveToDos(_ toDos: [ToDo]) {
		let propertyListEncoder: PropertyListEncoder = .init()
		do	{
			let codedMovies: Data = try propertyListEncoder.encode(toDos)
			try codedMovies.write(to: archiveURL)
		}
		catch	{
			print("Error saving movies: \(error)")
		}
	}
	
	static func loadBackupToDos() -> [ToDo] {
		let movieDates: [String: Date] = [
			"Funny Pages" : dateFrom(
				year: 2024,
				month: 11,
				day: 28
			),
			"House": dateFrom(
				year: 2025,
				month: 10,
				day: 31
			),
			"How to Succeed in Business Without Really Trying" : dateFrom(
				year: 2025,
				month: 7,
				day: 4
			),
			"La La Land" : dateFrom(
				year: 2025,
				month: 3,
				day: 2
			),
			"Megaloplis" : dateFrom(
				year: 2025,
				month: 2,
				day: 5
			),
			"Omni Loop": dateFrom(
				year: 2025,
				month: 9,
				day: 8
			),
			"The Apartment": dateFrom(
				year: 2024,
				month: 12,
				day: 31
			)
			
		]
		let moviesTitles = [
			"Funny Pages",
			"House",
			"How to Succeed in Business Without Really Trying",
			"La La Land",
			"Megalopolis",
			"Omni Loop",
			"The Apartment"
		]
		
		let toDoMovies: [ToDo] = moviesTitles.compactMap {
			title in
			guard let movie = Movie.movies.first(where: {	$0.title == title	}),
				  let watchByDate = movieDates[title]
			else {	return nil	}
			
			do {
				return try ToDo(movie: movie, watchByDate: watchByDate)
			} catch {
				print("""
   Error loading ToDo Item for \(title): 
   \(error.localizedDescription)
   """)
				return nil
			}
	}
		
		guard Movie.movies.count == movieDates.count else {
			print("Error with movie count")
			return []
		}
		
		return toDoMovies.enumerated().map {
			index, movie in
			guard let watchByDate = movieDates[movie.title] else {
				do {
					return try ToDo(movie: movie.movie, watchByDate: Date())
				} catch {
					print("""
  Error mapping movies:
  \(error.localizedDescription)
  """)
				}
				return try! ToDo(
					movie: Movie(
						title: "Fake Movie",
						description: "This is a fake movie",
						releaseYear: 2004,
						poster: UIImage()),
					watchByDate: Date())
			}
			do {
				return try ToDo(movie: movie.movie, watchByDate: watchByDate)
			} catch {
				print("""
Error mapping movies:
\(error.localizedDescription)
""")
				return try! ToDo(
					movie: Movie(
						title: "Fake Movie",
						description: "This is a fake movie",
						releaseYear: 2004,
						poster: UIImage()),
					watchByDate: Date())
			}
		}
	}
	
	private static func dateFrom(year: Int, month: Int, day: Int) -> Date {
		return Calendar.current.date(from: DateComponents(year: year, month: month, day: day))!
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
	
	init(movie: Movie, watchByDate: Date, hasWatched: Bool) throws {
		id = UUID()
		self.movie = movie
		self.hasWatched = hasWatched
		watchedOnDate = nil
		review = nil
		rating = nil
		self.watchByDate = watchByDate
	}
}

extension ToDo: Equatable {
	static func == (lhs: ToDo, rhs: ToDo) -> Bool {
		return lhs.id == rhs.id
	}
}

extension ToDo: Comparable {
	static func < (lhs: ToDo, rhs: ToDo) -> Bool {
		if lhs.hasWatched != rhs.hasWatched {
			return !lhs.hasWatched && rhs.hasWatched
		}
		
		if let lhsWatchByDate = lhs.watchByDate, let rhsWatchByDate = rhs.watchByDate {
			if lhsWatchByDate != rhsWatchByDate {
				return lhsWatchByDate < rhsWatchByDate
			}
		}

		if let lhsWatchedOnDate = lhs.watchedOnDate, let rhsWatchedOnDate = rhs.watchedOnDate {
			if lhsWatchedOnDate != rhsWatchedOnDate {
				return lhsWatchedOnDate < rhsWatchedOnDate
			}
		}

		return lhs.movie.title < rhs.movie.title
	}
}

extension ToDo: Codable {
	enum CodingKeys: String, CodingKey {
		case id
		case movie
		case hasWatched
		case watchedOnDate
		case review
		case rating
		case watchByDate
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		id = try container.decode(UUID.self, forKey: .id)
		movie = try container.decode(Movie.self, forKey: .movie)
		hasWatched = try  container.decode(Bool.self, forKey: .hasWatched)
		watchedOnDate = try container.decodeIfPresent(Date.self, forKey: .watchedOnDate)
		review = try container.decodeIfPresent(String.self, forKey: .review)
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
	}
	
	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)
		
		try container.encode(id, forKey: .id)
		try container.encode(movie, forKey: .movie)
		try container.encode(hasWatched, forKey: .hasWatched)
		try container.encode(watchedOnDate, forKey: .watchedOnDate)
		try container.encode(review, forKey: .review)
		try container.encode(rating, forKey: .rating)
	}
	
	static let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
	static let archiveURL = documentsDirectory.appendingPathComponent("toDo").appendingPathExtension("plist")
}


var toDoList: [ToDo] = ToDo.loadToDos()!
