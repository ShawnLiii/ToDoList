//
//  ToDo.swift
//  ToDoList
//
//  Created by Shawn Li on 4/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import Foundation

protocol EditDelegate {
    func Add(name: String, detail: String)
    func Edit(name: String, detail: String)
}

struct ToDo {
    var name = ""
    var checked = false
    var details: String = ""
}
