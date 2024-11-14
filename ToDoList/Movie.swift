//
//  Movie.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import Foundation
import UIKit

struct Movie {
	var id: UUID
	var title: String
	var description: String
	var poster: UIImage
	var releaseYear: Int
	
	static func loadMovies() -> [Movie] {
		[
			Movie(title: "Funny Pages",
				  description: "A bitingly funny coming-of-age story of a teenage cartoonist who rejects the comforts of his suburban life in a misguided quest for soul.",
				  releaseYear: 2022,
				  poster: #imageLiteral(resourceName: "FunnyPages2022.jpg")),
			Movie(title: "House",
				  description: "A schoolgirl and six of her classmates travel to her aunt's country home, which turns out to be haunted.",
				  releaseYear: 1977,
				  poster: #imageLiteral(resourceName: "House1977.jpg")),
			Movie(title: "How to Succeed in Business Without Really Trying",
				  description: "A young but bright former window cleaner rises to the top of his company by following the advice of a book about ruthless advancement in business.",
				  releaseYear: 1961,
				  poster: #imageLiteral(resourceName: "HowToSucceedInBusinessWithoutReallyTrying1961.jpg")),
			Movie(title: "La La Land",
				  description: "Mia, an aspiring actress, serves lattes to movie stars in between auditions and Sebastian, a jazz musician, scrapes by playing cocktail party gigs in dingy bars, but as success mounts they are faced with decisions that begin to fray the fragile fabric of their love affair, and the dreams they worked so hard to maintain in each other threaten to rip them apart.",
				  releaseYear: 2016,
				  poster: #imageLiteral(resourceName: "LaLaLand2016.jpg")),
			Movie(title: "Megaloplis",
				  description: "Genius artist Cesar Catilina seeks to leap the City of New Rome into a utopian, idealistic future, while his opposition, Mayor Franklyn Cicero, remains committed to a regressive status quo, perpetuating greed, special interests, and partisan warfare. Torn between them is socialite Julia Cicero, the mayor’s daughter, whose love for Cesar has divided her loyalties, forcing her to discover what she truly believes humanity deserves.",
				  releaseYear: 2024,
				  poster: #imageLiteral(resourceName: "Megaloplis2024.jpg")),
			Movie(title: "Omni Loop",
				  description: "Diagnosed with a black hole growing inside her chest and stuck in a loop reliving the last five days of her life, a 55-year-old wife and mother from Miami, Florida decides to solve time travel in order to go back and be the person she always intended to be.",
				  releaseYear: 2024,
				  poster: #imageLiteral(resourceName: "OmniLoop2024.jpg")),
			Movie(title: "The Apartment",
				  description: "Bud Baxter is a minor clerk in a huge New York insurance company, until he discovers a quick way to climb the corporate ladder. He lends out his apartment to the executives as a place to take their mistresses. Although he often has to deal with the aftermath of their visits, one night he's left with a major problem to solve.",
				  releaseYear: 1960,
				  poster: #imageLiteral(resourceName: "TheApartment1960.jpg"))
		]
	}
	
	init(id: UUID, title: String, description: String, poster: UIImage, releaseYear: Int) {
		self.id = id
		self.title = title
		self.description = description
		self.poster = poster
		self.releaseYear = releaseYear
	}
	
	init(title: String, description: String, releaseYear: Int, poster: UIImage) {
		id = UUID()
		self.title = title
		self.description = description
		self.poster = poster
		self.releaseYear = releaseYear
	}
}

extension Movie: Equatable {
	static func == (lhs: Movie, rhs: Movie) -> Bool {
		lhs.id == rhs.id
	}
}

extension Movie: Comparable {
	static func < (lhs: Movie, rhs: Movie) -> Bool {
		lhs.title < rhs.title
	}
}

extension Movie: Hashable {
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}
}
