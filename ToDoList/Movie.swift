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
