//
//  ToDoCell.swift
//  ToDoList_Weekday
//
//  Created by 진형진 on 2021/02/19.
//

import UIKit

class ToDoCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var contents: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
