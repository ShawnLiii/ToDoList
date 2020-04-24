//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Shawn Li on 4/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell
{

    @IBOutlet weak var checkMark: UILabel!
    @IBOutlet weak var todo: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
