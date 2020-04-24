//
//  EditController.swift
//  ToDoList
//
//  Created by Shawn Li on 4/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit



class EditController: UITableViewController
{

    var delegate: EditDelegate?
    var name: String?
    var detail: String?
    
    @IBOutlet weak var inputDetail: UITextView!
    @IBOutlet weak var inputName: UITextField!
    @IBAction func save(_ sender: Any)
    {
        
        if let name = inputName.text, !name.isEmpty
        {
            if self.name != nil
            {
                delegate?.Edit(name: name, detail: inputDetail.text)
            }
            else
            {
              delegate?.Add(name: name, detail: inputDetail.text)
            }
          
        }
        
        // dismiss this page
        navigationController?.popViewController(animated: true)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
         // automatic positioning
        inputName.becomeFirstResponder()
        inputName.text = name
        inputDetail.text = detail
        if name != nil
        {
            navigationItem.title = "Edit Task"
        }
    }

}
