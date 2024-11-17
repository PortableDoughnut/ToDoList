//
//  DateEditTableViewCell.swift
//  ToDoList
//
//  Created by Gwen Thelin on 11/15/24.
//

import UIKit

class DateEditTableViewCell: UITableViewCell {
	@IBOutlet weak var datePicker: UIDatePicker!
	

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
