//
//  AddMovieTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/13/24.
//

import UIKit
import Foundation

class AddMovieTableViewController: UITableViewController {
	@IBOutlet weak var movieDescriptionTextView: UITextView!
	
	var toReturnMovie: Movie?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		movieDescriptionTextView.layer.cornerRadius = 10
		movieDescriptionTextView.layer.borderWidth = 1
		movieDescriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
		movieDescriptionTextView.clipsToBounds = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
