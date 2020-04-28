//
//  ToDo.swift
//  ToDoList
//
//  Created by Shawn Li on 4/21/20.
//  Copyright © 2020 ShawnLi. All rights reserved.
//

import Foundation

protocol EditDelegate {
    func add(name: String, detail: String)
    func edit(name: String, detail: String)
}

struct ToDo: Codable {
    var name = ""
    var checked = false
    var details: String = ""
}

var todo = [
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
