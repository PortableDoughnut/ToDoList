//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import UIKit

class ToDoTableViewController: UITableViewController {
	
	var toDos: [ToDo] = []
	var movieToEdit: Movie = .init(
		title: "Fake Movie",
		description: "It's a fake movie",
		releaseYear: 2000,
		poster: UIImage())
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationItem.leftBarButtonItem = self.editButtonItem
		
		///Loading the data set
		if let savedToDos = ToDo.loadToDos() {
			toDos = savedToDos
		} else {
			toDos = []
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
			overrideUserInterfaceStyle = isDarkMode ? .dark : .light
			tableView.reloadData()
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	@IBAction func unwindToDoList(_ segue: UIStoryboardSegue) {
		if let sourceVC = segue.source as? AddWatchlistTableViewController {
			if let newToDo = sourceVC.toReturnToDo {
				toDos.append(newToDo)
			}
		} else if segue.source is MovieEditTableViewController {
		}
		toDos.sort()
		ToDo.saveToDos(toDos)
		tableView.reloadData()
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
#if DEBUG
		print("\(String(describing: cell.movieTitleLabel.text))")
#endif
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		124
	}
	// Override to support rearranging the table view.
	override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		toDos.swapAt(fromIndexPath.row, to.row)
		ToDo.saveToDos(toDos)
		tableView.reloadData()
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		performSegue(withIdentifier: "MovieDetailSegue", sender: toDos[indexPath.row])
	}
	
	override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
			self.toDos.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			completionHandler(true)
		}
		return UISwipeActionsConfiguration(actions: [deleteAction])
	}
	
	override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
		let editAction = UIContextualAction(style: .normal, title: toDos[indexPath.row].hasWatched ? "Edit" : "Watched") { _, _, completionHandler in
			self.showEdit(indexPath: indexPath)
			completionHandler(true)
		}
		editAction.backgroundColor = .systemBlue
		return UISwipeActionsConfiguration(actions: [editAction])
	}
	
	func showEdit(indexPath: IndexPath) {
		performSegue(withIdentifier: "MovieEditSegue", sender: toDos[indexPath.row])
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
	
	// MARK: - Navigation
	
	// In a storyboard-based application, you will often want to do a little preparation before navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let destination = segue.destination as? EditToDoTableViewController {
			guard let senderToDo = sender as? ToDo else { return }
			destination.toDoToEdit = senderToDo
		}
		
		if let destination = segue.destination as? MovieEditTableViewController {
			guard let senderToDo = sender as? ToDo else { return }
			destination.toDo = senderToDo
		}
	}
	
}
