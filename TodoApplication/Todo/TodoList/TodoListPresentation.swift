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
    let index: Int
    
    init(title: String, date : Date, index: Int) {
        self.title = title
        self.date = date
        self.index = index
    }
    
    init(todo: TodoListEntity, index: Int) {
        self.init(title: todo.name!, date: todo.finishTime!, index: index)
    }
}
