//
//  ToDoController.swift
//  ToDoList
//
//  Created by Shawn Li on 4/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit


class ToDoController: UITableViewController, EditDelegate, UIGestureRecognizerDelegate
{
     
    var todos: [[ToDo]] = [
        [ToDo(name:"Study Swift", checked: false, details: "I will study Swift all day long"),
         ToDo(name:"Prepare Exam", checked: false, details: "I should prepare for the first evaluation on Friday"),
         ToDo(name:"Hit Exercise", checked: false, details: "Need to do more exercise to keep health, Fucking COVID-19"),
         ToDo(name:"Making Food", checked: false, details: "Make some healthy food as well"),
         ToDo(name:"Making Food2", checked: false, details: "Make some healthy food as well"),
         ToDo(name:"Making Food3", checked: false, details: "Make some healthy food as well"),
         ToDo(name:"Making Food4", checked: false, details: "Make some healthy food as well"),
         ToDo(name:"Hit Exercise", checked: false, details: "Need to do more exercise to keep health, Fucking COVID-19"),
         ToDo(name:"Hit Exercise", checked: false, details: "Need to do more exercise to keep health, Fucking COVID-19"),
         ToDo(name:"Hit Exercise", checked: false, details: "Need to do more exercise to keep health, Fucking COVID-19"),
        ],
        [ToDo(name: "Hold a concert", checked: true, details: "I want to hold 32 concerts"),
        ToDo(name: "Find a girlfriend", checked: true, details: "I want a girl fiend"),
        ToDo(name: "GPA 4.0", checked: true, details: "It's easy"),
        ToDo(name: "GPA 4.0", checked: true, details: "It's easy"),
        ToDo(name: "GPA 4.0", checked: true, details: "It's easy"),
        ToDo(name: "GPA 4.0", checked: true, details: "It's easy"),
        ToDo(name: "GPA 4.0", checked: true, details: "It's easy")]
    ]
    var row = 0
    var column = 0
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    @IBAction func deleteBtn(_ sender: Any)
    {
//        Batch deletion of data
    
        if let indexPaths = tableView.indexPathsForSelectedRows
        {
            for indexPath in indexPaths
            {
                todos[indexPath.section].remove(at: indexPath.row)
            }
        
//        Update View
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
    override func viewDidLoad()
    {
//        super.viewDidLoad()
//        Uncomment the following line to preserve selection between presentations
//        self.clearsSelectionOnViewWillAppear = false
//
//        Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
//     Action of Edit button
    override func setEditing(_ editing: Bool, animated: Bool) {
//        inheritence from parent class to get all functions
        super.setEditing(editing, animated: animated)
        
        if isEditing
        {
            deleteBtn.isEnabled = true
        }
        else
        {
            deleteBtn.isEnabled = false
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        // #warning Incomplete implementation, return the number of sections
        return todos.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return todos[section].count
    }

   // view of Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todo", for: indexPath) as! ToDoCell
        // Configure the cell...
        cell.checkMark.text = todos[indexPath.section][indexPath.row].checked ? "✓" : ""
        cell.todo.text = todos[indexPath.section][indexPath.row].name
        
        //hard code to change cell style for each section
//        if (indexPath.section == 0)
//        {
//            cell.backgroundColor = .gray
//        }
        return cell
    }
    
    
    // what will happen when user select cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if !isEditing
        {
            //change data
            todos[indexPath.section][indexPath.row].checked = !todos[indexPath.section][indexPath.row].checked
            //change view
            let cell = tableView.cellForRow(at: indexPath) as! ToDoCell
            cell.checkMark.text = todos[indexPath.section][indexPath.row].checked ? "✓" : ""
            // deselect
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    // view for header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
//        @Method 1 TapGestureRecognizer
//
//        let headerView = UILabel()
//        headerView.text = "List of \(2020 - section)"
//        headerView.backgroundColor = UIColor.gray.withAlphaComponent(0.33)
//        headerView.textColor = .black
//        headerView.font = UIFont.systemFont(ofSize: 30)
//        headerView.isUserInteractionEnabled = true
//        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tapRecognizer.delegate = self
//        tapRecognizer.numberOfTapsRequired = 1
//        tapRecognizer.numberOfTouchesRequired = 1
//        headerView.addGestureRecognizer(tapRecognizer)
        
//        @Method 2 UIButton
        
        let headerView = UIButton(type: .custom)
        headerView.setTitle("List of \(2020 - section)", for: .normal)
        headerView.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        headerView.titleLabel?.textColor = UIColor.black
        headerView.backgroundColor = UIColor.gray.withAlphaComponent(0.33)
        headerView.addTarget(self, action: #selector(tapHeaderAction), for: .touchUpInside)
        
        return headerView
    }
    
//    @Method 1 TapGestureRecognizer Action
    @objc func handleTap(gestureRecognizer: UIGestureRecognizer)
    {
        alert()
    }

//    @Method 2 Button Action
    @objc func tapHeaderAction()
    {
        alert()
    }
    
    func alert ()
    {
//        Initialize Alert Controller
        let alertController = UIAlertController(title: "Awesome Bro", message: "This is Your To Do List", preferredStyle: .alert)
//         Initialize Actions
        let yesAction = UIAlertAction(title: "Got It", style: .default) { (action) -> Void in NSLog("The \"Got It\" alert occured.")}
//        let noAction = UIAlertAction(title: "Back", style: .default) { (action) -> Void in NSLog("The \"Not OK\" alert occured.")}
//         Add Actions
        alertController.addAction(yesAction)
//        alertController.addAction(noAction)
//         Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
//         Get the new view controller using segue.destination.
//         Pass the selected object data to the new view controller.
        if segue.identifier == "addTask"
        {
            let vc = segue.destination as! EditController
            vc.delegate = self
        }
        else if segue.identifier == "editTask"
        {
            let vc = segue.destination as! EditController
            let cell = sender as! ToDoCell
            row = tableView.indexPath(for: cell)!.row
            column = tableView.indexPath(for: cell)!.section
            vc.name = todos[column][row].name
            vc.detail = todos[column][row].details
            vc.delegate = self
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the data
            todos[indexPath.section].remove(at: indexPath.row)
            // Update View: Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
//        else if editingStyle == .insert
//        {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//      Move data
        let todo = todos[fromIndexPath.section][fromIndexPath.row]
        todos[fromIndexPath.section].remove(at: fromIndexPath.row)
        // move from one section to another section
        if to.section != fromIndexPath.section
        {
            todos[to.section].insert(todo, at: to.row)
            //        Update View
            tableView.beginUpdates()
//          tableView.moveSection(fromIndexPath.section, toSection: to.section)
            tableView.moveRow(at: fromIndexPath, to: to)
            tableView.endUpdates()
        }
        else
        {
            todos[fromIndexPath.section].insert(todo, at: to.row)
            //        Update View
            tableView.beginUpdates()
            tableView.moveRow(at: fromIndexPath, to: to)
            tableView.endUpdates()
        }
        
    }
    
    func Add(name: String, detail: String)
    {
//        Add data
        todos[0].append(ToDo(name: name, checked: false, details: detail))
//        Update view
        let indexPath = IndexPath(row: todos[0].count - 1, section: 0 )
        tableView.insertRows(at: [indexPath] , with: .automatic)
    }
   
    func Edit(name: String, detail: String)
    {
//        Edit Data
        todos[column][row].name = name
        todos[column][row].details = detail
//        Update View
        let indexPath = IndexPath(row: row, section: column)
        let cell = tableView.cellForRow(at: indexPath) as! ToDoCell
        cell.todo.text = name
    }
}
