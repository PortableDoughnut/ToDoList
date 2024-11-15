//
//  SeleectMovieTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/14/24.
//

import UIKit

class SelectMovieTableViewController: UITableViewController {
	
	var moviesArray: [Movie] = Movie.movies.sorted()
	var selectedMovie: Movie?
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return moviesArray.count
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "GenericMovieCell", for: indexPath) as? GenericMovieTableViewCell else {	return UITableViewCell()	}

		cell.configure(with: moviesArray[indexPath.row])

        return cell
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let destination = segue.destination as? AddWatchlistTableViewController,
			  let senderCell = sender as? GenericMovieTableViewCell
		else { return }
		
		selectedMovie = senderCell.movie
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
