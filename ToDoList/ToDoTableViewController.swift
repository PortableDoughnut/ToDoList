//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/11/24.
//

import UIKit

class ToDoTableViewController: UITableViewController {
	
	var ToDos: [ToDo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
		self.navigationItem.leftBarButtonItem = self.editButtonItem
		
		let movieToDoCell: UINib = .init(nibName: "ToDoTableViewCell", bundle: nil)
		tableView.register(movieToDoCell, forCellReuseIdentifier: "ToDoMovieCell")
		
		NotificationCenter.default.addObserver(self, selector: #selector(applyTheme), name: .themeChanged, object: nil)
    }

	@objc func applyTheme() {
		let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
		view.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {	1	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		toDoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoMovieCell", for: indexPath) as? ToDoTableViewCell else {	return UITableViewCell()	}

        // Configure the cell...
		cell.configure(with: toDoList[indexPath.row])
		print("\(String(describing: cell.movieTitleLabel.text))")

        return cell
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		92
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
			toDoList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
	
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
		toDoList.swapAt(fromIndexPath.row, to.row)
		tableView.reloadData()
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
