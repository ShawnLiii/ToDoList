//
//  ToDoController.swift
//  ToDoList
//
//  Created by Shawn Li on 4/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoController: UITableViewController, EditDelegate, UIGestureRecognizerDelegate
{
    let realm = try! Realm()
    
//    var todos: [[ToDo]] = [[]]
    var todos: Array<Results<ToDo>?>?
    var row = 0
    var column = 0
    
    @IBOutlet weak var deleteBtn: UIBarButtonItem!
    
    @IBAction func deleteBtn(_ sender: Any)
    {
//        Batch deletion of data
    
        if let indexPaths = tableView.indexPathsForSelectedRows
        {
            //
            for indexPath in indexPaths.reversed()
            {
                todos[indexPath.section].remove(at: indexPath.row)
            }
            
//          saveData()
//        Update View
            tableView.beginUpdates()
            tableView.deleteRows(at: indexPaths, with: .automatic)
            tableView.endUpdates()
        }
    }
    override func viewDidLoad()
    {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
       // read data from realm
        realm.objects(ToDo.self)
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
        return todos?.count ?? 1
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
        return cell
    }
    
    
    // what will happen when user select cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if !isEditing
        {
            //change data
            todos[indexPath.section][indexPath.row].checked = !todos[indexPath.section][indexPath.row].checked
//            saveData()
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
//         Add Actions
        alertController.addAction(yesAction)
//         Present Alert Controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {

        let vc = segue.destination as! EditController
        vc.delegate = self
        
        if segue.identifier == "editTask"
        {
            let cell = sender as! ToDoCell
            row = tableView.indexPath(for: cell)!.row
            column = tableView.indexPath(for: cell)!.section
            vc.name = todos[column][row].name
            vc.detail = todos[column][row].details
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            // Delete the data
            todos[indexPath.section].remove(at: indexPath.row)
//            saveData()
            // Update View: Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath)
    {
//      Move data
        let todo = todos[fromIndexPath.section][fromIndexPath.row]
        todos[fromIndexPath.section].remove(at: fromIndexPath.row)
        // move from one section to another section
        if to.section != fromIndexPath.section
        {
            todos[to.section].insert(todo, at: to.row)
            //        Update View
//            tableView.beginUpdates()
//            tableView.moveRow(at: fromIndexPath, to: to)
//            tableView.endUpdates()
            tableView.reloadData()
        }
        else
        {
            todos[fromIndexPath.section].insert(todo, at: to.row)
            //        Update View
//            tableView.beginUpdates()
//            tableView.moveRow(at: fromIndexPath, to: to)
//            tableView.endUpdates()
            tableView.reloadData()
        }
        
    }
    
    func add(name: String, detail: String)
    {
//        Add data
       let todo = ToDo()
        todo.name = name
        todo.details = detail
        todos[0].append(todo)
//        Store data into local 
        saveData(todo: todo)
//        Update view
        let indexPath = IndexPath(row: todos[0].count - 1, section: 0 )
        tableView.insertRows(at: [indexPath] , with: .automatic)
    }
   
    func edit(name: String, detail: String)
    {
//        Edit Data
        todos[column][row].name = name
        todos[column][row].details = detail
//        Store data into local
//        saveData()
//        Update View
        let indexPath = IndexPath(row: row, section: column)
        let cell = tableView.cellForRow(at: indexPath) as! ToDoCell
        cell.todo.text = name
    }
    
    func saveData(todo: ToDo)
    {
        do {
            try realm.write{
                realm.add(todo)
            }
        } catch  {
            print(error)
        }
    }
    
    
}
