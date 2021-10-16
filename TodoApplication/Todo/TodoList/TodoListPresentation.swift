//
//  TodoListPresentation.swift
//  TodoApplication
//
//  Created by Kibariye on 7.10.2021.
//

import Foundation

struct TodoListPresentation {
    let title: String
    let date:Date
    
    init(title: String, date : Date) {
        self.title = title
        self.date = date
    }
    
    init(todo: TodoListEntity) {
        self.init(title: todo.name!, date: todo.finishTime!)
    }
}
