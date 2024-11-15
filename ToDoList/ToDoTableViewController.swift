//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import UIKit

class ToDoTableViewController: UITableViewController {
	
	var toDos: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.leftBarButtonItem = self.editButtonItem
		
		///Loading the data set
		if let savedToDos = ToDo.loadToDos() {
			toDos = savedToDos
		} else {
			toDos = ToDo.loadToDos()!
		}
		
		toDos.sort()
		
		///Regestering the table view cell
		let movieToDoCell: UINib = .init(nibName: "ToDoTableViewCell", bundle: nil)
		tableView.register(movieToDoCell, forCellReuseIdentifier: "ToDoMovieCell")
		
		///Dark  Mode Logic
		NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: .themeChanged, object: nil)
    }

	@objc func applyTheme() {
		let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
		view.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	@IBAction func unwindToDoList(_ segue: UIStoryboardSegue) {
		if let sourceViewController = segue.source as? AddWatchlistTableViewController {
			toDos.append(sourceViewController.toReturnToDo!)
			toDos = toDos.sorted()
			tableView.reloadData()
		} else if let sourceViewController = segue.source as? AddMovieTableViewController {
			tableView.reloadData()
		}
	}
	
    // MARK: - Table view data source
	
    override func numberOfSections(in tableView: UITableView) -> Int {	1	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoMovieCell", for: indexPath) as? ToDoTableViewCell else {	return UITableViewCell()	}

        // Configure the cell...
		cell.configure(with: toDos[indexPath.row])
		print("\(String(describing: cell.movieTitleLabel.text))")

        return cell
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		124
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
			toDos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
	
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		toDos.swapAt(fromIndexPath.row, to.row)
		tableView.reloadData()
    }
	
	@IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
		let alertController = UIAlertController(
			title: "What do you want to add?",
			message: nil,
			preferredStyle: .actionSheet
		)
		
		let addMovie: UIAlertAction = .init(title: "Movie", style: .default) {
			_ in
			self.showAddMovie()
		}
		
		let addWatchlist: UIAlertAction = .init(title: "Watchlist Item", style: .default) {
			_ in
			self.showAddWatchlist()
		}
		
		let cancel: UIAlertAction = .init(title: "Cancel", style: .cancel, handler: nil)
		
		alertController.addAction(addMovie)
		alertController.addAction(addWatchlist)
		alertController.addAction(cancel)
		
		present(alertController, animated: true, completion: nil)
	}
	
	func showAddMovie() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		if let addMovieTableViewController = storyboard.instantiateViewController(withIdentifier: "AddMovieScene") as? AddMovieTableViewController {
			let addMovieNavigationController: UINavigationController = .init(rootViewController: addMovieTableViewController)
			present(addMovieNavigationController, animated: true, completion: nil)
		}
	}
	
	func showAddWatchlist() {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		
		if let addWatchlistTableViewController = storyboard.instantiateViewController(withIdentifier: "AddWatchlistScene") as? AddWatchlistTableViewController {
			let addWatchlistNavigationController: UINavigationController = .init(rootViewController: addWatchlistTableViewController)
			present(addWatchlistNavigationController, animated: true, completion: nil)
		}
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
