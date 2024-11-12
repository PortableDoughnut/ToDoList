//
//  StarLogicController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import Foundation
import UIKit

protocol StarSetterDelegate: AnyObject {
	func didSetStar(starOne: UIImage, starTwo: UIImage, starThree: UIImage, starFour: UIImage, starFive: UIImage)
}

class StarLogicController {
	weak var delegate: StarSetterDelegate?
	
	func setStar(_ toDo: ToDo, starArray: [UIImage]) {
		guard let rating = toDo.rating else { return }
		var localStarArray: [UIImage] = starArray
		
		for _ in localStarArray {
			if rating == floor(rating) {
				for index in 0..<Int(rating) {
					localStarArray[index] = UIImage(systemName: "star.fill")!
				}
			} else {
				for index in 0..<Int(floor(rating)) {
					localStarArray[index] = UIImage(systemName: "star.fill")!
				}
				localStarArray[Int(rating)] = UIImage(systemName: "star.leadinghalf.filled")!
			}
		}
		
		delegate?.didSetStar(starOne: localStarArray[0], starTwo: localStarArray[1], starThree: localStarArray[2], starFour: localStarArray[3], starFive: localStarArray[4])
	}
}
